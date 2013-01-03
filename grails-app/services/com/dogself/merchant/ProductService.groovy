package com.dogself.merchant

import com.dogself.core.Navigation
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.gualdi.grails.plugins.ckeditor.utils.PathUtils
import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.geom.AffineTransform
import java.awt.Graphics2D

class ProductService {

    def burningImageService

    static transactional = true

    /**
     * this is useful for creating navigation. since only a leaf navigation may have products, products must be copied to the leaf
     * @param from
     * @param to
     * @return
     */
    void moveProducts(Navigation from, Navigation to){
        List<Product> products = from.products;
        while(products.size() > 0){
            Product p = products.get(0);
            from.removeFromProducts(p);
            to.addToProducts(p);
        }
        from.save();
        to.save();
    }

    /**
     * Move a single product to another nav.
     * @param p
     * @param to
     */
    void moveProduct(Product p, Navigation to){
        Navigation from = p.navigation;
        from.removeFromProducts(p);
        to.addToProducts(p);
        from.save();
        to.save();
    }

    /**
     * saves a product under a navigation, or moves under the nav
     * (if product already lives under nav A this method will move it to nav B)
     * @param p
     * @param navId
     * @return
     */
    Navigation saveProduct(Product p, Long navId){
        Navigation parent = Navigation.findById(navId);
        Navigation oldParent = p.navigation;
        if(oldParent){
            oldParent.removeFromProducts(p)
        }
        parent.addToProducts(p);
        return parent.save();
    }

    /**
     * Deletes a product and removes it from its navigation parent
     * @param productId
     * @return parent navigation, which will contain errors (if any)
     */
    Navigation deleteProduct(Long productId){
        Product p = Product.findById(productId);
        Navigation parent = p.navigation;
        parent.removeFromProducts(p)
        parent.save();
        p.delete()
        File dir = new File(getProductImagesDir(productId));
        dir.delete();
        return parent;
    }

    /**
     * delete all the products under a navigation. this is useful for deleting a navigation and make sure the products
     * are cleared out
     * @param nav
     */
    void deleteAllProducts(Navigation nav){
        List<Product> products = nav.products;
        while(products.size() > 0){
            Product p = products.get(0);
            nav.removeFromProducts(p);
            File dir = new File(getProductImagesDir(p.id));
            dir.delete();
            p.delete();
        }
        nav.save();
    }

    Product updateProduct(Product p){
        p.save()
    }

    String getProductImagesDir(Long productId){
       return ConfigurationHolder.config.ckeditor.upload.basedir+"product_images_EDIT_AT_OWN_RISK/product_"+productId+"/";
    }

    String getProductThumbImagesDir(Long productId){
       return ConfigurationHolder.config.ckeditor.upload.basedir+"product_images_EDIT_AT_OWN_RISK/product_"+productId+"/thumb/";
    }

    boolean deleteProductImage(Long productId, String filename){
        File largeImage = new File(getProductImagesDir(productId), filename);
        File thumbImage = new File(getProductThumbImagesDir(productId), filename);
        boolean deleted = largeImage.exists() || thumbImage.exists();
        if(largeImage.exists()){
            largeImage.delete();
        }
        if(thumbImage.exists()){
            thumbImage.delete();
        }
        return deleted;
    }

    //get product image names from the product image dir
    List<String> getProductImageFilenames(Long productId)  {
        File dir = new File(getProductImagesDir(productId));
        if(dir.exists()){
            String[] files = dir.list([accept:{File d, String name ->
                    def fileParts = PathUtils.splitFilename(name)
                    def fileType = fileParts.ext?.toString()?.toLowerCase()
                    return (fileType in ConfigurationHolder.config.ckeditor.upload.image.allowed)
            }] as FilenameFilter);
            return files as List
        }
        return []
    }

    boolean rotate(String filename, Long productId, boolean clockwise) {
        def largeImg = new File(getProductImagesDir(productId), filename)
        def thumbImg = new File(getProductThumbImagesDir(productId), filename)
        if(rotate(thumbImg, clockwise)){
            if(!rotate(largeImg, clockwise)){
                rotate(thumbImg, !clockwise)
                return false;
            }
        }
        return true;
    }

    boolean rotate(File file, boolean clockwise) {
        if(!file.exists()){
            return false;
        }
        try {
            def image = ImageIO.read(file)
            double theta = clockwise ? Math.PI / 2 : -Math.PI / 2
            int w = image.width
            int h = image.height
            int anchor = clockwise ? h / 2 : w / 2
            BufferedImage rot = new BufferedImage(h, w, BufferedImage.TYPE_INT_RGB)
            AffineTransform at = AffineTransform.getRotateInstance(theta, anchor, anchor)
            Graphics2D g = (Graphics2D) rot.createGraphics()
            g.drawImage(image, at, null)
            def name = file.getName()
            def type = name.substring(name.lastIndexOf(".") + 1, name.length())
            ImageIO.write(rot, type, file)
        } catch (Exception e) {
            return false;
        };
        return true;
    }

    void createProductImages(String filename, Long productId, byte[] uploadedFile) {
        def userDir = new File(getProductImagesDir(productId))
        userDir.mkdirs()
        def thumbDir = new File(getProductThumbImagesDir(productId))
        thumbDir.mkdirs()
        filename = filename.replaceAll(/['"<>]/, "");
        File up = new File(userDir, filename);
        up.createNewFile();
        println "uploading file to:" + up.absolutePath
        FileOutputStream fos = new FileOutputStream(up);
        fos.write(uploadedFile)
        fos.flush();
        fos.close();

        burningImageService.doWith(up.absolutePath, userDir.absolutePath).execute{
            it.scaleApproximate(1024, 768)
        }
        burningImageService.doWith(up.absolutePath, thumbDir.absolutePath).execute {
            it.scaleApproximate(230, 176)
        }
    }

}

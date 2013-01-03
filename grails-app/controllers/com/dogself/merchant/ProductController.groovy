package com.dogself.merchant

import org.gualdi.grails.plugins.ckeditor.utils.MimeUtils
import org.gualdi.grails.plugins.ckeditor.utils.PathUtils

class ProductController {

    def productService

    def productImage = { //renders a product image

        def filename = productService.getProductImagesDir(Long.valueOf(params.id)) + params.filepath
        def ext = PathUtils.splitFilename(params.filepath).ext

        def contentType = MimeUtils.getMimeTypeByExt(ext)
        def file = new File(filename)

        response.setHeader("Content-Type", contentType)
        response.setHeader("Content-Length", "${file.size()}")

        def os = response.outputStream

        byte[] buff = null
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file))
        try
        {
            buff = new byte[2048]
            int bytesRead = 0
            while ((bytesRead = bis.read(buff, 0, buff.size())) != -1) {
                os.write(buff, 0, bytesRead)
            }
        }
        finally {
            bis.close()
            os.flush()
            os.close()
        }

        return null
    }

    def getProductImagesAjax = { //returns a list of product image names for fancybox to consume
        render(contentType:"text/json") {
           productService.getProductImageFilenames(params.getLong("id"));
        }
    }
}

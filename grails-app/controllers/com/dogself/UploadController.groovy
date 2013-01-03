package com.dogself

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import com.dogself.merchant.Product
import org.gualdi.grails.plugins.ckeditor.utils.PathUtils

class UploadController {

    def productService

    def productImages = {

        boolean good = false;
        byte[] uploadedFile = request.getInputStream().bytes
        def fileParts = PathUtils.splitFilename(params.qqfile)
        def fileType = fileParts.ext?.toString()?.toLowerCase()

        if(fileType in ConfigurationHolder.config.ckeditor.upload.image.allowed && uploadedFile.length && Product.findById(params.id)){
          productService.createProductImages(params.qqfile, params.getLong("id"), uploadedFile)
          good = true
        }
        render(contentType:"text/json") {
            [success:good]
        }
    }

}

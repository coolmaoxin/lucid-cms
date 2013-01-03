<%@ page contentType="text/html;charset=UTF-8" %>

%{--This page has two purposes, --}%
%{--1. lets user edit UserHtmlPage--}%
%{--2. lets user edit UserEditableSection--}%

<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Edit ${which == 'section' ? 'a section' : 'the contents'} of a page</h1>
<br/>
<div>Select a ${which} you would like to edit:</div>
<g:select name="pageSelect" from="${pages}" optionKey="${which == 'section' ? 'id' : 'userHtmlId'}" optionValue="${which == 'section' ? 'name' : 'crumb'}" noSelection="['':'Select one']" id="pageSelect"/>
<div class="hidden" id="edit">
    <div id="sizer"> %{--sizer helps size the textarea--}%
        Now that you have selected a ${which} to edit, use the editor below to edit the ${which}.<br/>
        Dont forget to hit save at the end or you will <b>lose your changes</b>!<br/><br/>
    </div>

    <ckeditor:editor id="editor" name="myeditor" showThumbs="true">

    </ckeditor:editor>
    <br/>
    <input type="button" id="save" value="Save and continue"/>
    <input type="button" id="saveAndFinish" value="Save and finish"/>
    <input type="button" id="more" value="Edit another ${which}"/> |
    <input type="button" id="exit" value="Back to admin"/>
</div>
<div class="ui-helper-clearfix"></div>
<script type="text/javascript">
    function saveChanges(cb) {
        cb = cb || function(){}
        var ckEditor = CKEDITOR.instances.editor;
        var id = $("#pageSelect").val();
        var html = ckEditor.getData();
        if (id != "") {
            $.post(ctxPath + "/admin/editHtmlAjax", {"id":id, "html": html, "which":"${which}"}, function(data) {
                if (data.success) {
                    $.jGrowl("Changes Saved");
                    cb();
                } else {
                    $.jGrowl("Something went wrong! Changes not saved");
                    $.jGrowl("Error: " + data.error);
                    //TODO: give user more info about what to do next
                }
            });
        } else {
            $.jGrowl("Select a page to edit first.");
        }
    }
    $(function() {

        var $edit = $("#edit");
        var $editor = $("#editor");
        var $sel = $("#pageSelect");

        var h = $("#mainContent").height() - $editor.offset().top - 55;
        $editor.width($("#sizer").width() - 10);
        $editor.height(h);

        var ckEditor = CKEDITOR.instances.editor;

        $sel.removeAttr("disabled");

        $sel.change(function() {
            if (this.value != "") {
                $edit.show();
                ckEditor.setData("Loading please wait...");
                $sel.attr("disabled", "disabled");
                $.getJSON(ctxPath + "/ajax/getEditableHtml?id=" + this.value+"&which=${which}", function(data) {
                    ckEditor.setData(data.html);
                    setMainContentHeight();
                });
            } else {
                $edit.hide();
            }
        }).val("");

        var idToEdit = getParameterByName("id");
        if(idToEdit){
            $sel.val(idToEdit);
            $sel.trigger("change");
        }

        $("#save").click(function(){
            saveChanges()
        });
        $("#saveAndFinish").click(function(){
            saveChanges(function(){
                window.location.href = ctxPath + "/admin/admin";
            });

        });
        $("#more").click(function() {
            if (window.confirm("Would you like to save your changes first?")) {
                saveChanges();
            }
            $sel.removeAttr("disabled");
            $edit.hide();
        });

    })

</script>
</body>
</html>
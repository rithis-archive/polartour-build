
(function(){var container,loader,symfio;require("coffee-script");symfio=require("symfio");container=symfio("polartour",__dirname);container.set("components",["modernizr#~2.6","store.js#~1.3","css_browser_selector","jquery#~1.9","jquery-ui#~1.9","jquery-file-upload#~7.2","select2#~3.3","angular#~1.0","angular-resource#~1.0","angular-cookies#~1.0","angular-ui-select2","semantic-grid","moment#~2.0","git://github.com/damirfoy/iCheck.git","jquery-galleria","typeahead.js#~0.9","jquery.scrollTo#~1.4","ckeditor","https://github.com/AlfonsoML/onchange.git","swfobject","jQuery-Timepicker-Addon"]);loader=container.get("loader");loader.use(require("symfio-contrib-bower"));loader.load();}).call(this);
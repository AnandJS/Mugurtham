// author:   Samuel Mueller 
// version: 1.0.7 
// license:  MIT 
// homepage: http://github.com/samu/angular-table 
(function(){var a,b,c,d,e,f,g,h,i,j,k={}.hasOwnProperty,l=function(a,b){function c(){this.constructor=a}for(var d in b)k.call(b,d)&&(a[d]=b[d]);return c.prototype=b.prototype,a.prototype=new c,a.__super__=b.prototype,a};angular.module("angular-table",[]),a=function(){function a(a,b){this.attribute=a.attribute,this.title=a.title,this.sortable=a.sortable,this.width=a.width,this.initialSorting=a.initialSorting,b&&(this.customContent=b.customContent,this.attributes=b.attributes)}return a.prototype.createElement=function(){var a;return a=angular.element(document.createElement("th"))},a.prototype.renderTitle=function(a){return a.html(this.customContent||this.title)},a.prototype.renderAttributes=function(a){var b,c,d,e,f;if(this.customContent){for(e=this.attributes,f=[],c=0,d=e.length;d>c;c++)b=e[c],f.push(a.attr(b.name,b.value));return f}},a.prototype.renderSorting=function(a){var b;return this.sortable?(a.attr("ng-click","predicate = '"+this.attribute+"'; descending = !descending;"),b=angular.element("<i style='margin-left: 10px;'></i>"),b.attr("ng-class","getSortIcon('"+this.attribute+"', predicate, descending)"),a.append(b)):void 0},a.prototype.renderWidth=function(a){return a.attr("width",this.width)},a.prototype.renderHtml=function(){var a;return a=this.createElement(),this.renderTitle(a),this.renderAttributes(a),this.renderSorting(a),this.renderWidth(a),a},a}(),i=function(){function a(a){this.configObjectName=a,this.itemsPerPage=""+this.configObjectName+".itemsPerPage",this.sortContext=""+this.configObjectName+".sortContext",this.fillLastPage=""+this.configObjectName+".fillLastPage",this.maxPages=""+this.configObjectName+".maxPages",this.currentPage=""+this.configObjectName+".currentPage",this.orderBy=""+this.configObjectName+".orderBy",this.paginatorLabels=""+this.configObjectName+".paginatorLabels"}return a}(),d=function(){function a(a,b,c){this.scope=a,this.configurationVariableNames=b,this.listName=c}return a.prototype.getList=function(){return this.scope.$eval(this.listName)},a.prototype.getItemsPerPage=function(){return this.scope.$eval(this.configurationVariableNames.itemsPerPage)||10},a.prototype.getCurrentPage=function(){return this.scope.$eval(this.configurationVariableNames.currentPage)||0},a.prototype.getMaxPages=function(){return this.scope.$eval(this.configurationVariableNames.maxPages)||void 0},a.prototype.getSortContext=function(){return this.scope.$eval(this.configurationVariableNames.sortContext)||"global"},a.prototype.setCurrentPage=function(a){return this.scope.$eval(""+this.configurationVariableNames.currentPage+"="+a)},a.prototype.getOrderBy=function(){return this.scope.$eval(this.configurationVariableNames.orderBy)||"orderBy"},a.prototype.getPaginatorLabels=function(){var a;return a={stepBack:"‹",stepAhead:"›",jumpBack:"«",jumpAhead:"»",first:"First",last:"Last"},this.scope.$eval(this.configurationVariableNames.paginatorLabels)||a},a}(),h=function(){function b(a,b){this.tableElement=a,this.attributes=b,this.id=this.attributes.id,this.config=this.attributes.atConfig,this.paginated=null!=this.attributes.atPaginated,this.list=this.attributes.atList,this.createColumnConfigurations()}return b.prototype.capitaliseFirstLetter=function(a){return a?a.charAt(0).toUpperCase()+a.slice(1):""},b.prototype.extractWidth=function(a){var b;return b=/([0-9]+px)/i.exec(a),b?b[0]:""},b.prototype.isSortable=function(a){var b;return b=/(sortable)/i.exec(a),b?!0:!1},b.prototype.getInitialSorting=function(a){var b;if(b=a.attr("at-initial-sorting")){if("asc"===b||"desc"===b)return b;throw"Invalid value for initial-sorting: "+b+". Allowed values are 'asc' or 'desc'."}return void 0},b.prototype.collectHeaderMarkup=function(a){var b,c,d,e,f,g;for(b={},d=a.find("tr"),g=d.find("th"),e=0,f=g.length;f>e;e++)c=g[e],c=angular.element(c),b[c.attr("at-attribute")]={customContent:c.html(),attributes:c[0].attributes};return b},b.prototype.collectBodyMarkup=function(a){var b,c,d,e,f,g,h,i,j,k;for(c=[],k=a.find("td"),i=0,j=k.length;j>i;i++)f=k[i],f=angular.element(f),b=f.attr("at-attribute"),g=f.attr("at-title")||this.capitaliseFirstLetter(f.attr("at-attribute")),e=void 0!==f.attr("at-sortable")||this.isSortable(f.attr("class")),h=this.extractWidth(f.attr("class")),d=this.getInitialSorting(f),c.push({attribute:b,title:g,sortable:e,width:h,initialSorting:d});return c},b.prototype.createColumnConfigurations=function(){var b,c,d,e,f;for(c=this.collectHeaderMarkup(this.tableElement),b=this.collectBodyMarkup(this.tableElement),this.columnConfigurations=[],e=0,f=b.length;f>e;e++)d=b[e],this.columnConfigurations.push(new a(d,c[d.attribute]))},b}(),e=function(){function a(){}return a.prototype.setupTr=function(a,b){var c,d;return c=a.find("tbody"),d=c.find("tr"),d.attr("ng-repeat",b),c},a}(),f=function(a){function b(a,b){this.list=b,this.repeatString="item in "+this.list+" | orderBy:predicate:descending"}return l(b,a),b.prototype.compile=function(a,b,c){return this.setupTr(a,this.repeatString)},b.prototype.link=function(){},b}(e),c=function(a){function b(a){this.configurationVariableNames=a,this.repeatString="item in sortedAndPaginatedList"}return l(b,a),b.prototype.compile=function(a){var b,c,d,e,f,g,h;for(c=this.setupTr(a,this.repeatString),f=a.find("td"),e="",g=0,h=f.length;h>g;g++)d=f[g],e+="<td><span>&nbsp;</span></td>";b=angular.element(document.createElement("tr")),b.attr("ng-show",this.configurationVariableNames.fillLastPage),b.html(e),b.attr("ng-repeat","item in fillerArray"),c.append(b)},b.prototype.link=function(a,b,c,e){var f,g,h,i,j;return f=this.configurationVariableNames,j=new d(a,f,c.atList),h=function(a,b,c,d,e,f,g,h){var i,j;return a?(j=a,i=c*b-a.length,"global"===e?(j=h(d)(j,f,g),j=h("limitTo")(j,i),j=h("limitTo")(j,c)):(j=h("limitTo")(j,i),j=h("limitTo")(j,c),j=h(d)(j,f,g)),j):[]},g=function(a,b,c,d){var e,f,g,h,i,j,k,l,m,n;if(d=parseInt(d),a.length<=0){for(m=[],g=h=0,j=d-1;j>=0?j>=h:h>=j;g=j>=0?++h:--h)m.push(g);return m}if(b===c-1){if(f=a.length%d,0!==f){for(e=d-f-1,n=[],g=i=k=a.length,l=a.length+e;l>=k?l>=i:i>=l;g=l>=k?++i:--i)n.push(g);return n}return[]}},i=function(){var b;return a.sortedAndPaginatedList=h(j.getList(),j.getCurrentPage(),j.getItemsPerPage(),j.getOrderBy(),j.getSortContext(),a.predicate,a.descending,e),b=Math.ceil(j.getList().length/j.getItemsPerPage()),a.fillerArray=g(j.getList(),j.getCurrentPage(),b,j.getItemsPerPage())},a.$watch(f.currentPage,function(){return i()}),a.$watch(f.itemsPerPage,function(){return i()}),a.$watch(f.sortContext,function(){return i()}),a.$watchCollection(c.atList,function(){return i()}),a.$watch(""+c.atList+".length",function(){return a.numberOfPages=Math.ceil(j.getList().length/j.getItemsPerPage()),i()}),a.$watch("predicate",function(){return i()}),a.$watch("descending",function(){return i()})},b}(e),g=function(){function a(a,b,c){this.element=a,this.tableConfiguration=b,this.configurationVariableNames=c}return a.prototype.constructHeader=function(){var a,b,c,d,e;for(b=angular.element(document.createElement("tr")),e=this.tableConfiguration.columnConfigurations,c=0,d=e.length;d>c;c++)a=e[c],b.append(a.renderHtml());return b},a.prototype.setupHeader=function(){var a,b,c;return b=this.element.find("thead"),b?(a=this.constructHeader(),c=angular.element(b).find("tr"),c.remove(),b.append(a)):void 0},a.prototype.getSetup=function(){return this.tableConfiguration.paginated?new c(this.configurationVariableNames):new f(this.configurationVariableNames,this.tableConfiguration.list)},a.prototype.compile=function(){return this.setupHeader(),this.setup=this.getSetup(),this.setup.compile(this.element)},a.prototype.setupInitialSorting=function(a){var b,c,d,e,f;for(e=this.tableConfiguration.columnConfigurations,f=[],c=0,d=e.length;d>c;c++)if(b=e[c],b.initialSorting){if(!b.attribute)throw"initial-sorting specified without attribute.";a.predicate=b.attribute,f.push(a.descending="desc"===b.initialSorting)}else f.push(void 0);return f},a.prototype.post=function(a,b,c,d){return this.setupInitialSorting(a),a.getSortIcon||(a.getSortIcon=function(b,c,d){return b!==a.predicate?"glyphicon glyphicon-minus":d?"glyphicon glyphicon-chevron-down":"glyphicon glyphicon-chevron-up"}),this.setup.link(a,b,c,d)},a}(),b=function(){function a(a,b,c,d){if(this.lowerBound=null!=a?a:0,this.upperBound=null!=b?b:1,null==c&&(c=0),this.length=null!=d?d:1,this.length>this.upperBound-this.lowerBound)throw"sequence is too long";this.data=this.generate(c)}return a.prototype.generate=function(a){var b,c,d,e;for(a>this.upperBound-this.length?a=this.upperBound-this.length:a<this.lowerBound&&(a=this.lowerBound),e=[],b=c=a,d=parseInt(a)+parseInt(this.length)-1;d>=a?d>=c:c>=d;b=d>=a?++c:--c)e.push(b);return e},a.prototype.resetParameters=function(a,b,c){if(this.lowerBound=a,this.upperBound=b,this.length=c,this.length>this.upperBound-this.lowerBound)throw"sequence is too long";return this.data=this.generate(this.data[0])},a.prototype.relocate=function(a){var b;return b=this.data[0]+a,this.data=this.generate(b,b+this.length)},a.prototype.realignGreedy=function(a){var b;return a<this.data[0]?(b=a,this.data=this.generate(b)):a>this.data[this.length-1]?(b=a-(this.length-1),this.data=this.generate(b)):void 0},a.prototype.realignGenerous=function(a){},a}(),j="<div style='margin: 0px;'> <ul class='pagination'> <li ng-class='{disabled: getCurrentPage() <= 0}'> <a href='' ng-click='stepPage(-numberOfPages)'>{{getPaginatorLabels().first}}</a> </li> <li ng-show='showSectioning()' ng-class='{disabled: getCurrentPage() <= 0}'> <a href='' ng-click='jumpBack()'>{{getPaginatorLabels().jumpBack}}</a> </li> <li ng-class='{disabled: getCurrentPage() <= 0}'> <a href='' ng-click='stepPage(-1)'>{{getPaginatorLabels().stepBack}}</a> </li> <li ng-class='{active: getCurrentPage() == page}' ng-repeat='page in pageSequence.data'> <a href='' ng-click='goToPage(page)' ng-bind='page + 1'></a> </li> <li ng-class='{disabled: getCurrentPage() >= numberOfPages - 1}'> <a href='' ng-click='stepPage(1)'>{{getPaginatorLabels().stepAhead}}</a> </li> <li ng-show='showSectioning()' ng-class='{disabled: getCurrentPage() >= numberOfPages - 1}'> <a href='' ng-click='jumpAhead()'>{{getPaginatorLabels().jumpAhead}}</a> </li> <li ng-class='{disabled: getCurrentPage() >= numberOfPages - 1}'> <a href='' ng-click='stepPage(numberOfPages)'>{{getPaginatorLabels().last}}</a> </li> </ul> </div>",angular.module("angular-table").directive("atTable",["$filter",function(a){return{restrict:"AC",scope:!0,compile:function(b,c,d){var e,f,j;return j=new h(b,c),e=new i(c.atConfig),f=new g(b,j,e),f.compile(),{post:function(b,c,d){return f.post(b,c,d,a)}}}}}]),angular.module("angular-table").directive("atPagination",[function(){return{restrict:"E",scope:!0,replace:!0,template:j,link:function(a,c,e){var f,g,h,j,k,l;return f=new i(e.atConfig),l=new d(a,f,e.atList),h=function(a,b,c){return a=Math.max(b,a),Math.min(c,a)},g=function(){return a.numberOfPages},j=function(b){return a.numberOfPages=b},k=function(b){var c,d;return l.getList()?l.getList().length>0?(c=Math.ceil(l.getList().length/l.getItemsPerPage()),j(c),d=a.showSectioning()?l.getMaxPages():c,a.pageSequence.resetParameters(0,c,d),l.setCurrentPage(h(l.getCurrentPage(),0,g()-1)),a.pageSequence.realignGreedy(l.getCurrentPage())):(j(1),a.pageSequence.resetParameters(0,1,1),l.setCurrentPage(0),a.pageSequence.realignGreedy(0)):void 0},a.showSectioning=function(){return l.getMaxPages()&&g()>l.getMaxPages()},a.getCurrentPage=function(){return l.getCurrentPage()},a.getPaginatorLabels=function(){return l.getPaginatorLabels()},a.stepPage=function(b){return b=parseInt(b),l.setCurrentPage(h(l.getCurrentPage()+b,0,g()-1)),a.pageSequence.realignGreedy(l.getCurrentPage())},a.goToPage=function(a){return l.setCurrentPage(a)},a.jumpBack=function(){return a.stepPage(-l.getMaxPages())},a.jumpAhead=function(){return a.stepPage(l.getMaxPages())},a.pageSequence=new b,a.$watch(f.itemsPerPage,function(){return k()}),a.$watch(f.maxPages,function(){return k()}),a.$watch(e.atList,function(){return k()}),a.$watch(""+e.atList+".length",function(){return k()}),k()}}}]),angular.module("angular-table").directive("atImplicit",[function(){return{restrict:"AC",compile:function(a,b,c){var d;if(d=a.attr("at-attribute"),!d)throw"at-implicit specified without at-attribute: "+a.html();return a.append("<span ng-bind='item."+d+"'></span>")}}}])}).call(this);
/**
 * dirPagination - AngularJS module for paginating (almost) anything.
 *
 *
 * Credits
 * =======
 *
 * Daniel Tabuenca: https://groups.google.com/d/msg/angular/an9QpzqIYiM/r8v-3W1X5vcJ
 * for the idea on how to dynamically invoke the ng-repeat directive.
 *
 * I borrowed a couple of lines and a few attribute names from the AngularUI Bootstrap project:
 * https://github.com/angular-ui/bootstrap/blob/master/src/pagination/pagination.js
 *
 * Copyright 2014 Michael Bromley <michael@michaelbromley.co.uk>
 */

(function() {

    /**
     * Config
     */
    var moduleName = 'angularUtils.directives.dirPagination';
    var DEFAULT_ID = '__default';

    /**
     * Module
     */
    angular.module(moduleName, [])
        .directive('dirPaginate', ['$compile', '$parse', 'paginationService', dirPaginateDirective])
        .directive('dirPaginateNoCompile', noCompileDirective)
        .directive('dirPaginationControls', ['paginationService', 'paginationTemplate', dirPaginationControlsDirective])
        .filter('itemsPerPage', ['paginationService', itemsPerPageFilter])
        .service('paginationService', paginationService)
        .provider('paginationTemplate', paginationTemplateProvider)
        .run(['$templateCache',dirPaginationControlsTemplateInstaller]);

    function dirPaginateDirective($compile, $parse, paginationService) {

        return  {
            terminal: true,
            multiElement: true,
            priority: 100,
            compile: dirPaginationCompileFn
        };

        function dirPaginationCompileFn(tElement, tAttrs){

            var expression = tAttrs.dirPaginate;
            // regex taken directly from https://github.com/angular/angular.js/blob/v1.4.x/src/ng/directive/ngRepeat.js#L339
            var match = expression.match(/^\s*([\s\S]+?)\s+in\s+([\s\S]+?)(?:\s+as\s+([\s\S]+?))?(?:\s+track\s+by\s+([\s\S]+?))?\s*$/);

            var filterPattern = /\|\s*itemsPerPage\s*:\s*(.*\(\s*\w*\)|([^\)]*?(?=\s+as\s+))|[^\)]*)/;
            if (match[2].match(filterPattern) === null) {
                throw 'pagination directive: the \'itemsPerPage\' filter must be set.';
            }
            var itemsPerPageFilterRemoved = match[2].replace(filterPattern, '');
            var collectionGetter = $parse(itemsPerPageFilterRemoved);

            addNoCompileAttributes(tElement);

            // If any value is specified for paginationId, we register the un-evaluated expression at this stage for the benefit of any
            // dir-pagination-controls directives that may be looking for this ID.
            var rawId = tAttrs.paginationId || DEFAULT_ID;
            paginationService.registerInstance(rawId);

            return function dirPaginationLinkFn(scope, element, attrs){

                // Now that we have access to the `scope` we can interpolate any expression given in the paginationId attribute and
                // potentially register a new ID if it evaluates to a different value than the rawId.
                var paginationId = $parse(attrs.paginationId)(scope) || attrs.paginationId || DEFAULT_ID;
                // In case rawId != paginationId we deregister using rawId for the sake of general cleanliness
                // before registering using paginationId
                paginationService.deregisterInstance(rawId);
                paginationService.registerInstance(paginationId);

                var repeatExpression = getRepeatExpression(expression, paginationId);
                addNgRepeatToElement(element, attrs, repeatExpression);

                removeTemporaryAttributes(element);
                var compiled =  $compile(element);

                var currentPageGetter = makeCurrentPageGetterFn(scope, attrs, paginationId);
                paginationService.setCurrentPageParser(paginationId, currentPageGetter, scope);

                if (typeof attrs.totalItems !== 'undefined') {
                    paginationService.setAsyncModeTrue(paginationId);
                    scope.$watch(function() {
                        return $parse(attrs.totalItems)(scope);
                    }, function (result) {
                        if (0 <= result) {
                            paginationService.setCollectionLength(paginationId, result);
                        }
                    });
                } else {
                    paginationService.setAsyncModeFalse(paginationId);
                    scope.$watchCollection(function() {
                        return collectionGetter(scope);
                    }, function(collection) {
                        if (collection) {
                            var collectionLength = (collection instanceof Array) ? collection.length : Object.keys(collection).length;
                            paginationService.setCollectionLength(paginationId, collectionLength);
                        }
                    });
                }

                // Delegate to the link function returned by the new compilation of the ng-repeat
                compiled(scope);
                    
                // When the scope is destroyed, we make sure to remove the reference to it in paginationService
                // so that it can be properly garbage collected
                scope.$on('$destroy', function destroyDirPagination() {
                    paginationService.deregisterInstance(paginationId);
                });
            };
        }

        /**
         * If a pagination id has been specified, we need to check that it is present as the second argument passed to
         * the itemsPerPage filter. If it is not there, we add it and return the modified expression.
         *
         * @param expression
         * @param paginationId
         * @returns {*}
         */
        function getRepeatExpression(expression, paginationId) {
            var repeatExpression,
                idDefinedInFilter = !!expression.match(/(\|\s*itemsPerPage\s*:[^|]*:[^|]*)/);

            if (paginationId !== DEFAULT_ID && !idDefinedInFilter) {
                repeatExpression = expression.replace(/(\|\s*itemsPerPage\s*:\s*[^|\s]*)/, "$1 : '" + paginationId + "'");
            } else {
                repeatExpression = expression;
            }

            return repeatExpression;
        }

        /**
         * Adds the ng-repeat directive to the element. In the case of multi-element (-start, -end) it adds the
         * appropriate multi-element ng-repeat to the first and last element in the range.
         * @param element
         * @param attrs
         * @param repeatExpression
         */
        function addNgRepeatToElement(element, attrs, repeatExpression) {
            if (element[0].hasAttribute('dir-paginate-start') || element[0].hasAttribute('data-dir-paginate-start')) {
                // using multiElement mode (dir-paginate-start, dir-paginate-end)
                attrs.$set('ngRepeatStart', repeatExpression);
                element.eq(element.length - 1).attr('ng-repeat-end', true);
            } else {
                attrs.$set('ngRepeat', repeatExpression);
            }
        }

        /**
         * Adds the dir-paginate-no-compile directive to each element in the tElement range.
         * @param tElement
         */
        function addNoCompileAttributes(tElement) {
            angular.forEach(tElement, function(el) {
                if (el.nodeType === 1) {
                    angular.element(el).attr('dir-paginate-no-compile', true);
                }
            });
        }

        /**
         * Removes the variations on dir-paginate (data-, -start, -end) and the dir-paginate-no-compile directives.
         * @param element
         */
        function removeTemporaryAttributes(element) {
            angular.forEach(element, function(el) {
                if (el.nodeType === 1) {
                    angular.element(el).removeAttr('dir-paginate-no-compile');
                }
            });
            element.eq(0).removeAttr('dir-paginate-start').removeAttr('dir-paginate').removeAttr('data-dir-paginate-start').removeAttr('data-dir-paginate');
            element.eq(element.length - 1).removeAttr('dir-paginate-end').removeAttr('data-dir-paginate-end');
        }

        /**
         * Creates a getter function for the current-page attribute, using the expression provided or a default value if
         * no current-page expression was specified.
         *
         * @param scope
         * @param attrs
         * @param paginationId
         * @returns {*}
         */
        function makeCurrentPageGetterFn(scope, attrs, paginationId) {
            var currentPageGetter;
            if (attrs.currentPage) {
                currentPageGetter = $parse(attrs.currentPage);
            } else {
                // If the current-page attribute was not set, we'll make our own.
                // Replace any non-alphanumeric characters which might confuse
                // the $parse service and give unexpected results.
                // See https://github.com/michaelbromley/angularUtils/issues/233
                var defaultCurrentPage = (paginationId + '__currentPage').replace(/\W/g, '_');
                scope[defaultCurrentPage] = 1;
                currentPageGetter = $parse(defaultCurrentPage);
            }
            return currentPageGetter;
        }
    }

    /**
     * This is a helper directive that allows correct compilation when in multi-element mode (ie dir-paginate-start, dir-paginate-end).
     * It is dynamically added to all elements in the dir-paginate compile function, and it prevents further compilation of
     * any inner directives. It is then removed in the link function, and all inner directives are then manually compiled.
     */
    function noCompileDirective() {
        return {
            priority: 5000,
            terminal: true
        };
    }

    function dirPaginationControlsTemplateInstaller($templateCache) {
        $templateCache.put('angularUtils.directives.dirPagination.template', '<ul class="pagination" ng-if="1 < pages.length || !autoHide"><li ng-if="boundaryLinks" ng-class="{ disabled : pagination.current == 1 }"><a href="" ng-click="setCurrent(1)">&laquo;</a></li><li ng-if="directionLinks" ng-class="{ disabled : pagination.current == 1 }"><a href="" ng-click="setCurrent(pagination.current - 1)">&lsaquo;</a></li><li ng-repeat="pageNumber in pages track by tracker(pageNumber, $index)" ng-class="{ active : pagination.current == pageNumber, disabled : pageNumber == \'...\' || ( ! autoHide && pages.length === 1 ) }"><a href="" ng-click="setCurrent(pageNumber)">{{ pageNumber }}</a></li><li ng-if="directionLinks" ng-class="{ disabled : pagination.current == pagination.last }"><a href="" ng-click="setCurrent(pagination.current + 1)">&rsaquo;</a></li><li ng-if="boundaryLinks"  ng-class="{ disabled : pagination.current == pagination.last }"><a href="" ng-click="setCurrent(pagination.last)">&raquo;</a></li></ul>');
    }

    function dirPaginationControlsDirective(paginationService, paginationTemplate) {

        var numberRegex = /^\d+$/;

        var DDO = {
            restrict: 'AE',
            scope: {
                maxSize: '=?',
                onPageChange: '&?',
                paginationId: '=?',
                autoHide: '=?'
            },
            link: dirPaginationControlsLinkFn
        };

        // We need to check the paginationTemplate service to see whether a template path or
        // string has been specified, and add the `template` or `templateUrl` property to
        // the DDO as appropriate. The order of priority to decide which template to use is
        // (highest priority first):
        // 1. paginationTemplate.getString()
        // 2. attrs.templateUrl
        // 3. paginationTemplate.getPath()
        var templateString = paginationTemplate.getString();
        if (templateString !== undefined) {
            DDO.template = templateString;
        } else {
            DDO.templateUrl = function(elem, attrs) {
                return attrs.templateUrl || paginationTemplate.getPath();
            };
        }
        return DDO;

        function dirPaginationControlsLinkFn(scope, element, attrs) {

            // rawId is the un-interpolated value of the pagination-id attribute. This is only important when the corresponding dir-paginate directive has
            // not yet been linked (e.g. if it is inside an ng-if block), and in that case it prevents this controls directive from assuming that there is
            // no corresponding dir-paginate directive and wrongly throwing an exception.
            var rawId = attrs.paginationId ||  DEFAULT_ID;
            var paginationId = scope.paginationId || attrs.paginationId ||  DEFAULT_ID;

            if (!paginationService.isRegistered(paginationId) && !paginationService.isRegistered(rawId)) {
                var idMessage = (paginationId !== DEFAULT_ID) ? ' (id: ' + paginationId + ') ' : ' ';
                if (window.console) {
                    console.warn('Pagination directive: the pagination controls' + idMessage + 'cannot be used without the corresponding pagination directive, which was not found at link time.');
                }
            }

            if (!scope.maxSize) { scope.maxSize = 9; }
            scope.autoHide = scope.autoHide === undefined ? true : scope.autoHide;
            scope.directionLinks = angular.isDefined(attrs.directionLinks) ? scope.$parent.$eval(attrs.directionLinks) : true;
            scope.boundaryLinks = angular.isDefined(attrs.boundaryLinks) ? scope.$parent.$eval(attrs.boundaryLinks) : false;

            var paginationRange = Math.max(scope.maxSize, 5);
            scope.pages = [];
            scope.pagination = {
                last: 1,
                current: 1
            };
            scope.range = {
                lower: 1,
                upper: 1,
                total: 1
            };

            scope.$watch('maxSize', function(val) {
                if (val) {
                    paginationRange = Math.max(scope.maxSize, 5);
                    generatePagination();
                }
            });

            scope.$watch(function() {
                if (paginationService.isRegistered(paginationId)) {
                    return (paginationService.getCollectionLength(paginationId) + 1) * paginationService.getItemsPerPage(paginationId);
                }
            }, function(length) {
                if (0 < length) {
                    generatePagination();
                }
            });

            scope.$watch(function() {
                if (paginationService.isRegistered(paginationId)) {
                    return (paginationService.getItemsPerPage(paginationId));
                }
            }, function(current, previous) {
                if (current != previous && typeof previous !== 'undefined') {
                    goToPage(scope.pagination.current);
                }
            });

            scope.$watch(function() {
                if (paginationService.isRegistered(paginationId)) {
                    return paginationService.getCurrentPage(paginationId);
                }
            }, function(currentPage, previousPage) {
                if (currentPage != previousPage) {
                    goToPage(currentPage);
                }
            });

            scope.setCurrent = function(num) {
                if (paginationService.isRegistered(paginationId) && isValidPageNumber(num)) {
                    num = parseInt(num, 10);
                    paginationService.setCurrentPage(paginationId, num);
                }
            };

            /**
             * Custom "track by" function which allows for duplicate "..." entries on long lists,
             * yet fixes the problem of wrongly-highlighted links which happens when using
             * "track by $index" - see https://github.com/michaelbromley/angularUtils/issues/153
             * @param id
             * @param index
             * @returns {string}
             */
            scope.tracker = function(id, index) {
                return id + '_' + index;
            };

            function goToPage(num) {
                if (paginationService.isRegistered(paginationId) && isValidPageNumber(num)) {
                    var oldPageNumber = scope.pagination.current;

                    scope.pages = generatePagesArray(num, paginationService.getCollectionLength(paginationId), paginationService.getItemsPerPage(paginationId), paginationRange);
                    scope.pagination.current = num;
                    updateRangeValues();

                    // if a callback has been set, then call it with the page number as the first argument
                    // and the previous page number as a second argument
                    if (scope.onPageChange) {
                        scope.onPageChange({
                            newPageNumber : num,
                            oldPageNumber : oldPageNumber
                        });
                    }
                }
            }

            function generatePagination() {
                if (paginationService.isRegistered(paginationId)) {
                    var page = parseInt(paginationService.getCurrentPage(paginationId)) || 1;
                    scope.pages = generatePagesArray(page, paginationService.getCollectionLength(paginationId), paginationService.getItemsPerPage(paginationId), paginationRange);
                    scope.pagination.current = page;
                    scope.pagination.last = scope.pages[scope.pages.length - 1];
                    if (scope.pagination.last < scope.pagination.current) {
                        scope.setCurrent(scope.pagination.last);
                    } else {
                        updateRangeValues();
                    }
                }
            }

            /**
             * This function updates the values (lower, upper, total) of the `scope.range` object, which can be used in the pagination
             * template to display the current page range, e.g. "showing 21 - 40 of 144 results";
             */
            function updateRangeValues() {
                if (paginationService.isRegistered(paginationId)) {
                    var currentPage = paginationService.getCurrentPage(paginationId),
                        itemsPerPage = paginationService.getItemsPerPage(paginationId),
                        totalItems = paginationService.getCollectionLength(paginationId);

                    scope.range.lower = (currentPage - 1) * itemsPerPage + 1;
                    scope.range.upper = Math.min(currentPage * itemsPerPage, totalItems);
                    scope.range.total = totalItems;
                }
            }
            function isValidPageNumber(num) {
                return (numberRegex.test(num) && (0 < num && num <= scope.pagination.last));
            }
        }

        /**
         * Generate an array of page numbers (or the '...' string) which is used in an ng-repeat to generate the
         * links used in pagination
         *
         * @param currentPage
         * @param rowsPerPage
         * @param paginationRange
         * @param collectionLength
         * @returns {Array}
         */
        function generatePagesArray(currentPage, collectionLength, rowsPerPage, paginationRange) {
            var pages = [];
            var totalPages = Math.ceil(collectionLength / rowsPerPage);
            var halfWay = Math.ceil(paginationRange / 2);
            var position;

            if (currentPage <= halfWay) {
                position = 'start';
            } else if (totalPages - halfWay < currentPage) {
                position = 'end';
            } else {
                position = 'middle';
            }

            var ellipsesNeeded = paginationRange < totalPages;
            var i = 1;
            while (i <= totalPages && i <= paginationRange) {
                var pageNumber = calculatePageNumber(i, currentPage, paginationRange, totalPages);

                var openingEllipsesNeeded = (i === 2 && (position === 'middle' || position === 'end'));
                var closingEllipsesNeeded = (i === paginationRange - 1 && (position === 'middle' || position === 'start'));
                if (ellipsesNeeded && (openingEllipsesNeeded || closingEllipsesNeeded)) {
                    pages.push('...');
                } else {
                    pages.push(pageNumber);
                }
                i ++;
            }
            return pages;
        }

        /**
         * Given the position in the sequence of pagination links [i], figure out what page number corresponds to that position.
         *
         * @param i
         * @param currentPage
         * @param paginationRange
         * @param totalPages
         * @returns {*}
         */
        function calculatePageNumber(i, currentPage, paginationRange, totalPages) {
            var halfWay = Math.ceil(paginationRange/2);
            if (i === paginationRange) {
                return totalPages;
            } else if (i === 1) {
                return i;
            } else if (paginationRange < totalPages) {
                if (totalPages - halfWay < currentPage) {
                    return totalPages - paginationRange + i;
                } else if (halfWay < currentPage) {
                    return currentPage - halfWay + i;
                } else {
                    return i;
                }
            } else {
                return i;
            }
        }
    }

    /**
     * This filter slices the collection into pages based on the current page number and number of items per page.
     * @param paginationService
     * @returns {Function}
     */
    function itemsPerPageFilter(paginationService) {

        return function(collection, itemsPerPage, paginationId) {
            if (typeof (paginationId) === 'undefined') {
                paginationId = DEFAULT_ID;
            }
            if (!paginationService.isRegistered(paginationId)) {
                throw 'pagination directive: the itemsPerPage id argument (id: ' + paginationId + ') does not match a registered pagination-id.';
            }
            var end;
            var start;
            if (angular.isObject(collection)) {
                itemsPerPage = parseInt(itemsPerPage) || 9999999999;
                if (paginationService.isAsyncMode(paginationId)) {
                    start = 0;
                } else {
                    start = (paginationService.getCurrentPage(paginationId) - 1) * itemsPerPage;
                }
                end = start + itemsPerPage;
                paginationService.setItemsPerPage(paginationId, itemsPerPage);

                if (collection instanceof Array) {
                    // the array just needs to be sliced
                    return collection.slice(start, end);
                } else {
                    // in the case of an object, we need to get an array of keys, slice that, then map back to
                    // the original object.
                    var slicedObject = {};
                    angular.forEach(keys(collection).slice(start, end), function(key) {
                        slicedObject[key] = collection[key];
                    });
                    return slicedObject;
                }
            } else {
                return collection;
            }
        };
    }

    /**
     * Shim for the Object.keys() method which does not exist in IE < 9
     * @param obj
     * @returns {Array}
     */
    function keys(obj) {
        if (!Object.keys) {
            var objKeys = [];
            for (var i in obj) {
                if (obj.hasOwnProperty(i)) {
                    objKeys.push(i);
                }
            }
            return objKeys;
        } else {
            return Object.keys(obj);
        }
    }

    /**
     * This service allows the various parts of the module to communicate and stay in sync.
     */
    function paginationService() {

        var instances = {};
        var lastRegisteredInstance;

        this.registerInstance = function(instanceId) {
            if (typeof instances[instanceId] === 'undefined') {
                instances[instanceId] = {
                    asyncMode: false
                };
                lastRegisteredInstance = instanceId;
            }
        };

        this.deregisterInstance = function(instanceId) {
            delete instances[instanceId];
        };
        
        this.isRegistered = function(instanceId) {
            return (typeof instances[instanceId] !== 'undefined');
        };

        this.getLastInstanceId = function() {
            return lastRegisteredInstance;
        };

        this.setCurrentPageParser = function(instanceId, val, scope) {
            instances[instanceId].currentPageParser = val;
            instances[instanceId].context = scope;
        };
        this.setCurrentPage = function(instanceId, val) {
            instances[instanceId].currentPageParser.assign(instances[instanceId].context, val);
        };
        this.getCurrentPage = function(instanceId) {
            var parser = instances[instanceId].currentPageParser;
            return parser ? parser(instances[instanceId].context) : 1;
        };

        this.setItemsPerPage = function(instanceId, val) {
            instances[instanceId].itemsPerPage = val;
        };
        this.getItemsPerPage = function(instanceId) {
            return instances[instanceId].itemsPerPage;
        };

        this.setCollectionLength = function(instanceId, val) {
            instances[instanceId].collectionLength = val;
        };
        this.getCollectionLength = function(instanceId) {
            return instances[instanceId].collectionLength;
        };

        this.setAsyncModeTrue = function(instanceId) {
            instances[instanceId].asyncMode = true;
        };

        this.setAsyncModeFalse = function(instanceId) {
            instances[instanceId].asyncMode = false;
        };

        this.isAsyncMode = function(instanceId) {
            return instances[instanceId].asyncMode;
        };
    }

    /**
     * This provider allows global configuration of the template path used by the dir-pagination-controls directive.
     */
    function paginationTemplateProvider() {

        var templatePath = 'angularUtils.directives.dirPagination.template';
        var templateString;

        /**
         * Set a templateUrl to be used by all instances of <dir-pagination-controls>
         * @param {String} path
         */
        this.setPath = function(path) {
            templatePath = path;
        };

        /**
         * Set a string of HTML to be used as a template by all instances
         * of <dir-pagination-controls>. If both a path *and* a string have been set,
         * the string takes precedence.
         * @param {String} str
         */
        this.setString = function(str) {
            templateString = str;
        };

        this.$get = function() {
            return {
                getPath: function() {
                    return templatePath;
                },
                getString: function() {
                    return templateString;
                }
            };
        };
    }
})();
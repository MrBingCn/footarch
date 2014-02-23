<?xml version="1.0" encoding="utf-8"?>
<mx:Canvas 
         xmlns:fx="http://ns.adobe.com/mxml/2009"
         xmlns:s="library://ns.adobe.com/flex/spark"
         xmlns:mx="library://ns.adobe.com/flex/mx"
         width="100%" height="100%"
         xmlns:util="com.globalwave.common.*" 
         xmlns:validator="com.globalwave.common.validator.*"
		 xmlns:${e.entityName}="com.globalwave.${e.moduleName}.${e.entityName}.*">
		 
    <fx:Declarations>
        <fx:Array id="validators">
            <#list g.getSearchForm().getFields() as f>
<#include "validator.inc" parse="true" encoding="UTF-8">
            </#list>
        </fx:Array>
    </fx:Declarations>
    
    <fx:Script>
    <![CDATA[
        import com.globalwave.common.appframe.module.AppModule;
        import com.globalwave.util.ValidateUtil;
		
        public function doSearch() : void {
            listGrid.criterion = ValidateUtil.getParams(validators, "so") ;
            
            listGrid.doRefresh() ;
        }
		
        private function listGridOnDblClick(even:MouseEvent):void {
            (this.parent as AppModule).onButtonClick({click:"edit"}) ;
        }
    ]]>
    </fx:Script>

	<mx:VBox width="100%" height="100%">
		<mx:HBox verticalAlign="middle" paddingTop="4">
	      <#list g.getSearchForm().getFields() as f>
             <#include "field.inc" parse="true" encoding="UTF-8">
          </#list>  
			<mx:Button id="search" label="查询" click="doSearch()" icon="@Embed(source='../../image/button/Search.png')"/>
		</mx:HBox>
		
		<${e.entityName}:${e.className}DataGrid id="listGrid" pagination="{paginationBar}" />
		
		<util:Pagination id="paginationBar" pageIndex="{listGrid.dataset.pageIndex}" 
						 total="{listGrid.dataset.total}" pageChanged="listGrid.doRefresh()"/>
		
	</mx:VBox>    
</mx:Canvas>

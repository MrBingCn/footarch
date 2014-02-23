<?xml version="1.0" encoding="utf-8"?>
<module:AppModule xmlns:fx="http://ns.adobe.com/mxml/2009" 
                  xmlns:s="library://ns.adobe.com/flex/spark" 
                  xmlns:mx="library://ns.adobe.com/flex/mx"
                  xmlns:module="com.globalwave.common.appframe.module.*"
                  xmlns:${e.entityName}="com.globalwave.${e.moduleName}.${e.entityName}.*"
                  initialize="init()">
    <fx:Script>
        <![CDATA[
            import com.globalwave.common.event.RecordEvent;
            import com.globalwave.${e.moduleName}.${e.entityName}.${e.className}EditWindow;
            
            public function init():void {
                this.windowClass = com.globalwave.${e.moduleName}.${e.entityName}.${e.className}EditWindow ;
                this.deleteUrl = "/${e.moduleName}/${e.entityName}_delete" ;
               <#list g.getEditForm().getFields() as f>
                 <#if f.getIs_primary_key() == 1>
                this.idName = "${f.code_}" ;
                 </#if>
               </#list>                  
               
            }
            
            override public function getSelectedItems():Array {
                return this.workspace.listGrid.selectedItems ;
            }
            
            override public function refreshOnDataUpdate(event:RecordEvent):void {
                this.workspace.listGrid.doRefresh() ;
            }
        ]]>
    </fx:Script>
    <${e.entityName}:${e.className}Workspace id="workspace"/>
</module:AppModule>
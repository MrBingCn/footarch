<?xml version="1.0" encoding="utf-8"?>
<DataGrid xmlns="com.globalwave.common.*" 
    xmlns:mx="http://www.adobe.com/2006/mxml" 
    xmlns:datagridrenderer="com.globalwave.common.datagridrenderer.*" 
    doubleClickEnabled = "true"
    initialize="init()">
    <mx:Script>
      <![CDATA[
		  import com.globalwave.common.event.RecordEvent;
		  import com.globalwave.util.HttpServiceUtil;
      
      [Bindable]
      public var showCheckbox : Boolean = false ;
    
      public function init() : void {
          
          super.url = "/${e.moduleName}/${e.entityName}_list" ;
          super.entityName = "${e.className}" ;
   <#list g.getEditForm().getFields() as f>
     <#if f.getIs_primary_key() == 1>    
          super.idName = "${f.code_}" ;
     </#if>
   </#list>            
		  super.isInitRefresh = false ;
      } 
      
      override public function doRefresh() : void {
          
          super.doRefresh() ;
      }
          
      public function addRecordCompleted(event:RecordEvent) : void {
          doRefresh() ;
      } 
        
      public function updateRecordCompleted(event:RecordEvent) : void {
          updateRecord(new XML(event.record)) ;
      }
        
      public function deleteRecordCompleted(event:RecordEvent) : void {
          doRefresh() ;
      }
      ]]>
  </mx:Script>
  
    <columns>
		<!-- <datagridrenderer:CheckBoxHeaderColumn dataField="{selectDataField}" selected="{data.selected}" visible="{showCheckbox}"/> -->
   <#list g.getFields() as f>
        <mx:DataGridColumn dataField="${f.code_}" headerText="${f.name_}"  width="200"/>
   </#list>  
    </columns>
    
</DataGrid>

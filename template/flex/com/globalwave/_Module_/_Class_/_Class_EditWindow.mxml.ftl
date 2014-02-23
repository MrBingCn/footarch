<?xml version="1.0" encoding="utf-8"?>
<EditWindow xmlns="com.globalwave.common.*" 
            xmlns:fx="http://ns.adobe.com/mxml/2009"
            xmlns:s="library://ns.adobe.com/flex/spark"
            xmlns:mx="library://ns.adobe.com/flex/mx"
            xmlns:validator="com.globalwave.common.validator.*"
            width="600" 
            height="600"
            title="${g.view.name_}"  >
    
    <fx:Declarations>
        <fx:Array id="validators">
           <#list g.getEditForm().getFields() as f>
<#include "validator.inc" parse="true" encoding="UTF-8">
           </#list>
        </fx:Array>
    </fx:Declarations>
    
    <fx:Script>
        <![CDATA[
			import com.globalwave.common.event.RecordEvent;
			import com.globalwave.util.Convertor;
			import com.globalwave.util.HttpServiceUtil;
			import com.globalwave.util.ValidateUtil;
			
			import flash.display.DisplayObject;
			
			import mx.controls.*;
			import mx.core.Application;
			import mx.core.FlexGlobals;
			import mx.core.UIComponent;
			import mx.events.FlexEvent;
			import mx.events.FocusRequestDirection;
			import mx.managers.IFocusManager;
			import mx.managers.PopUpManager;
			import mx.rpc.events.ResultEvent;
			import mx.rpc.http.HTTPService;
                    
            override public function init():void { 
                super.saveButton = this.btSave ;     
                super.entityName = "${e.className}" ;  
        
                super.init();
            }
            
            private function save():void {
                                
                var params : Object = ValidateUtil.getParams(this.validators, "${e.entityName}") ;

                if (params == null) {
                    return ;
                }

                var httpService : HTTPService ;
				
                if (updateObject == null) {
                    httpService = HttpServiceUtil.getService("/${e.moduleName}/${e.entityName}_create") ;
                } else {
               <#list g.getEditForm().getFields() as f>
                 <#if f.getIs_primary_key() == 1>    
                    params["${e.entityName}.${f.code_}"] = updateObject.${f.code_} ;
                 </#if>
               </#list>
                    httpService = HttpServiceUtil.getService("/${e.moduleName}/${e.entityName}_update") ;
                }
                
                httpService.addEventListener(ResultEvent.RESULT,saveCompleted) ;
                httpService.send(params);
            }
            
            
				
			//移动焦点*******        
			private function nextFocus(event:FlexEvent):void 
			{ 
				var fm:IFocusManager=(event.currentTarget as UIComponent).focusManager; 
				fm.getNextFocusManagerComponent().setFocus();
			} 
        ]]>
    </fx:Script>
    <mx:VBox width="100%" height="100%" paddingTop="10">
			<mx:Form width="90%" height="80%" id="mainForm" >
               <#list g.getEditForm().getFields() as f>
                 <#if f.getIs_primary_key() == 0>
<#include "field.inc" parse="true" encoding="UTF-8">
                 </#if>
               </#list>
			</mx:Form>

      <mx:HRule width="100%" />

      <mx:HBox horizontalAlign="center" width="100%" > 
        <mx:Button id="btSave" click="save()" icon="@Embed(source='../../image/Button/Save.png')" label="保存"/> 
        <mx:Button id="btClose" click="closeMe()" icon="@Embed(source='../../image/Button/Cancel.png')" label="关闭"/> 
      </mx:HBox> 
      
    </mx:VBox>
</EditWindow>

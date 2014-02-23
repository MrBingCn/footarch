                <mx:FormItem label="${f.name_}" width="100%" labelWidth="150" <#if f.getIs_nullable() == 0>required="true"</#if>>
                 <#if !f.getInput_type()??>
                    <mx:TextInput id="${f.code_}" text="{updateObject.${f.code_}}" width="100%"/>
                 <#elseif f.getInput_type() == "CodeComboBox">
                    <CodeComboBox id="${f.code_}" code="XX.yyyy.${f.code_}" selectedValue="{updateObject.${f.code_}}"/>
                 <#elseif f.getInput_type() == "DateField">
                    <DateField id="${f.code_}" text="{updateObject.${f.code_}}" width="100%"/>
                 <#elseif f.getInput_type() == "Radio">
                    <CodeComboBox id="${f.code_}" code="XX.yyyy.${f.code_}" selectedValue="{updateObject.${f.code_}}"/>
                 <#else>
                    <mx:TextInput id="${f.code_}" text="{updateObject.${f.code_}}" width="100%"/>
                 </#if>
                </mx:FormItem>

             <#if f.getIs_primary_key() == 0>
            <validator:SmartValidator source="{${f.code_}}" property="<#if !f.input_type??>text<#elseif f.getInput_type() == "CodeComboBox">selectedValue<#elseif f.getInput_type() == "Radio">selectedValue<#elseif f.getInput_type() == "DateField">text<#else>text</#if>" <#if f.getIs_nullable() == 1>required="false"</#if> maxLength="25"/>
             </#if>

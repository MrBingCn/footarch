
	<!-- for ${e.moduleName} ${e.className} config //-->
	<bean id="${e.entityName}Service" scope="prototype" class="com.globalwave.${e.moduleName}.service.${e.className}ServiceImpl" />
	<bean id="${e.moduleName}_${e.entityName}Action" scope="prototype" class="com.globalwave.${e.moduleName}.web.${e.className}Action"/>	
	 
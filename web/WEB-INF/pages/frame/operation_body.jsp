<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <div class="admin_nav">
            <ul id="adminNav">
                <li><a href="javascript:addTab('/demo/grid_div.jsp');" class="link_top">回首页</a></li>
                <li>
                    <span href="#">线路管理</span>
                    <div>
                        <a href="#">港口设置</a>
                        <a href="#">航线设置</a>
                        <a href="#">国家管理</a>
                    </div>
                </li>
                <li>
                    <span href="#">基础数据配置</span>
                    <div id="navBaseConfig">
                        <!-- <a href="#1" onclick="hlt.material.getItemList(1);return false;">货物类型</a>
                        <a href="#2" onclick="hlt.material.getItemList(2);return false;">客户类型</a>
                        <a href="#3" onclick="hlt.material.getItemList(3);return false;">业务类型</a>
                        <a href="#4" onclick="hlt.material.getItemList(4);return false;">报关方式</a>
                        <a href="#5" onclick="hlt.material.getItemList(5);return false;">拖柜方式</a>
                        <a href="#6" onclick="hlt.material.getItemList(6);return false;">提单类型</a>
                        <a href="#7" onclick="hlt.material.getItemList(7);return false;">运输条款</a> -->
                        <!--<a href="#8">运费条款</a>-->
                        <!-- <a href="#9" onclick="hlt.material.getItemList(9);return false;">委托类型</a>
                        <a href="#10" onclick="hlt.material.getItemList(10);return false;">付款方式</a>
                        <a href="#11" onclick="hlt.material.getItemList(11);return false;">货柜类型</a>
                        <a href="#12" onclick="hlt.material.getItemList(12);return false;">洲</a>
                        <a href="#13" onclick="hlt.material.getItemList(13);return false;">货物代码</a>
                        <a href="#14">船公司管理</a> -->
                        
                    </div>
                </li>
                <li>
                    <span>客户/公司管理</span>
                    <div>
                        <a href="#" onclick="hlt.company.getList(1,1);return false;">公司管理</a>
                        <a href="#">联系人管理</a>
                    </div>
                </li>
                <li>
                    <span href="#">用户管理</span>
                    <div>
                        <a href="javascript:addTab('/system/user_view.action')">用户管理</a>
                        <a href="#">角色管理</a>
                        <a href="#">权限管理</a>
                    </div>
                </li>
            </ul>
            <script type="text/javascript">
                hlt.material.getList(hlt.material.makeNav);
                $('#adminNav span').click(function(){
                    if (this.parentNode.className == 'active') {
                        this.parentNode.className = '';
                    } else {
                        $('#adminNav li').removeClass('active');
                        this.parentNode.className = 'active';
                    }
                })
            </script>
        </div>
        <%-- 
        <div class="admin_action">
            <div class="admin_action_inner">
                <h3>位置：系统设置</h3>
                <div class="admin_area">
                    <div class="admin_system" id="adminSystem">

                    </div>
                </div>
            </div>
        </div>
         --%>
         
        <div class="admin_action">
            <div class="admin_action_inner">
			    <div id="tabs">
			        <ul>
			            <li><a href="#tabs-1">Nunc tincidunt</a> <span class="ui-icon ui-icon-close">Remove Tab</span></li>
			        </ul>
			        <div id="tabs-1" class="admin_area">
			            <p >Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>
			        </div>
			    </div>
            </div>
        </div>
        <script>
        var $tabs = $( "#tabs").tabs({
            tabTemplate: "<li><a href='<%="#{href}"%>'><%="#{label}"%></a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>",
            add: function( event, ui ) {
                var tab_content = "Tab " + tab_counter + " content.";
                //$( ui.panel ).append( "<p>" + tab_content + "</p>" );
                $.ajax({
                    type: "post",
                    url: "<%=request.getContextPath()%>" + url + "?view_id=" + tab_counter,
                    dataType:"html",
                    success: function(data, textStatus, jqXHR){
                        //$("#tabs-" + tab_counter).html(jqXHR.responseText);
                        $( ui.panel ).append( jqXHR.responseText );
                        var reponse = jQuery(jqXHR.responseText);
                        var reponseScript = reponse.filter("script");
                        $.each(reponseScript, function(idx, val) { 
                        	try{
                        		//alert(val.text);
                        		eval(val.text);
                        	}catch(e){
                        		alert(e);
                        	} 
                        });
                        ui.panel.viewJs = eval("g$v"+tab_counter) ;
                        ui.panel.viewJs.init();
                        //setTimeout(list, 1000);
                        //list();
                    }
                });
            }
        });
        var tab_counter = 2;
        var viewJs = null ;
        var url = null ;
        // actual addTab function: adds new tab using the title input from the form above
        function addTab(url_) {
            var tab_title = "Tab " + tab_counter;
            
            tab_counter++;
            
            url = url_ ;
            
            $tabs.tabs( "add", "#tabs-" + tab_counter, tab_title );
        }

        // close icon: removing the tab on click
        // note: closable tabs gonna be an option in the future - see http://dev.jqueryui.com/ticket/3924
        $( "#tabs span.ui-icon-close" ).live( "click", function() {
            var index = $( "li", $tabs ).index( $( this ).parent() );
            
            if (viewJs != null) {
                eval("g$v"+viewJs.id + "=null;") ;//clean js object
            }

            $tabs.tabs( "remove", index );
        });
        
        
        $('#tabs').bind('tabsshow', function(event, ui) {
        	viewJs = ui.panel.viewJs ;
        });
        </script>
    </div>
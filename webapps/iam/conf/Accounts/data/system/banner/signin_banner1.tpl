<html>
    <head>
    
    </head>
    <body style="background-color: #f9f9f9; padding: 50px; font-family: Zoho Puvi;">
    
    <!--   BANNER TYPE 1     -->
    	<style type="text/css">
      		.banner1_img{
      			display:block;
      			width: 300px; 
      			height: 240px; 
      			margin:auto;
      			background-size: 100%;
      		}
      		.banner1_heading{ 
      			font-size: 16px; 
      			font-weight: 600; 
      			margin-top: 20px; 
      		}
      		.banner1_content{
      			font-size: 14px; 
      			font-weight: 400; 
      			margin-top: 10px; 
      		}
      		.banner1_href{ 
      			width: max-content; 
      			max-width: 160px;  
      			margin: auto; 
      			margin-top: 20px; 
      			background-color: #ECF7FE; 
      			color: #0091FF; 
      			font-weight: 600; 
      			border-radius: 18px; 
      			padding: 8px 20px; 
      			border: none; 
      			cursor: pointer; 
      			text-decoration: none; 
      			box-sizing: border-box; 
      			font-size: 14px; 
      		}
      		.banner1_heading,.banner1_content,.banner1_href{
      			display: block; 
      			line-height: 20px;
      			text-align: center; 
      		}
    	</style>
        <div class="container" >
            <div class="banner1_img" style="background-image: url('${IMAGE}');"></div>
            <div class="banner1_heading">${HEADING}</div>
            <div style="" class="banner1_content">${CONTENT} </div>
            <a class="banner1_href" href="${LEARNMOREURL}" target="_blank"> Learn more </a>
        </div>      
        
    </body>
    
</html>

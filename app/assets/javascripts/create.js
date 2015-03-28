	$('#file').change(
				function() {
					if ( !this.files.length ) {
						return;
					}
					var file = $(this).prop('files')[0];
					var fr = new FileReader();
					fr.onload = function() {
						$('#back_image').attr({
							'src': fr.result,
							'width': 0,
							'height' : 0
						}).show();
					}
					fr.readAsDataURL(file);
				}
				);
			$('#back_image').load(function(){
					var c = document.getElementById("mycanvas");
					var ctx = c.getContext("2d");
					var img = document.getElementById("back_image");
					ctx.drawImage(img, 0, 0,300,300);
				})
			$(function() {
				var canvas = document.getElementById('mycanvas');
				if (!canvas || !canvas.getContext) return false;
				var ctx = canvas.getContext('2d');
				var startX,
				startY,
				x,
				y,
				borderWidth = 10,
				isDrawing = false;
				$('#mycanvas').mousedown(function(e) {
					isDrawing = true;
					startX = e.pageX - $(this).offset().left - borderWidth;
					startY = e.pageY - $(this).offset().top - borderWidth;
				})
				
				.mousemove(function(e) {
					if (!isDrawing) return;
					x = e.pageX - $(this).offset().left - borderWidth;
					y = e.pageY - $(this).offset().top - borderWidth;
					ctx.beginPath();
					ctx.moveTo(startX, startY);
					ctx.lineTo(x, y);
					ctx.stroke();
					startX = x;
					startY = y;
				})
				.mouseup(function() {
					isDrawing = false;
				})
				.mouseleave(function() {
					isDrawing = false;
				});
				$('#penColor').change(function() {
					ctx.strokeStyle = $(this).val();
				});
				$('#penWidth').change(function() {
					ctx.lineWidth = $(this).val();
				});
				$('#save').click(function() {
					var img = $('<img id="myImg">').attr({
						width: 0,
						height:0,
						src: canvas.toDataURL()
					});
					var link = $('<a>').attr({
						href: canvas.toDataURL().replace('image/jpg', 'application/octet-stream'),
					});
					$('#gallery').append(link.append(img));
					ctx.clearRect(0, 0, canvas.width, canvas.height);
				});
				$("#save").on("click", function () {
					var canvas = $("img#myImg").attr("src");
					$("#article_image").val(""); 
					$("#article_remote_image_url").val(canvas);
				});
			});
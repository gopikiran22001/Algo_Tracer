from PIL import Image, ImageDraw, ImageFont

img = Image.new('RGB', (1024, 1024), '#000000')

try:
    font = ImageFont.truetype('ariali.ttf', 800)
except:
    try:
        font = ImageFont.truetype('arial.ttf', 800)
    except:
        font = ImageFont.load_default()

temp_img = Image.new('RGBA', (1024, 1024), (0, 0, 0, 0))
temp_draw = ImageDraw.Draw(temp_img)

bbox = temp_draw.textbbox((0, 0), 'A', font=font)
text_width = bbox[2] - bbox[0]
text_height = bbox[3] - bbox[1]
x = (1024 - text_width) // 2 - bbox[0]
y = (1024 - text_height) // 2 - bbox[1] - 50

temp_draw.text((x, y), 'A', fill='#1DCD9F', font=font)
rotated = temp_img.rotate(-10, expand=False, fillcolor=(0, 0, 0, 0))
img.paste(rotated, (0, 0), rotated)
img.save('assets/app_icon.png')
print('Icon created successfully')

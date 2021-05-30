from flask import Flask, redirect, url_for, request
from PIL import Image, ImageFont, ImageDraw
import textwrap
import io
import base64

app = Flask(__name__)


# Normal Function 
def write_text(text_to_write, image_size):
    image_text = Image.new("RGB", image_size)
    font = ImageFont.load_default().font
    drawer = ImageDraw.Draw(image_text)

    #Text wrapping. Change parameters for different text formatting
    margin = offset = 10
    for line in textwrap.wrap(text_to_write, width=60):
        drawer.text((margin,offset), line, font=font)
        offset += 10
    return image_text

# Page Routes
@app.route("/")
def home():
    return "Hello, World!"
    
@app.route("/encode",methods=['POST'])
def encode_image():
    try:
        data = request.get_json()
        text_to_encode = data['text']
        print("TEXT: ",data['text'])
        imgbyte = data['img']
   #     print("BYTES: ",imgbyte)
        imgdata = base64.b64decode(imgbyte)
        filename = 'encoded_image.png'
        with open(filename, 'wb') as f:
            f.write(imgdata)
    except:
        print("Error!")
        return "Some error occurred!"
        exit(0)

    template_image = Image.open('encoded_image.png')

    red_template = template_image.split()[0]
    green_template = template_image.split()[1]
    blue_template = template_image.split()[2]
    # print("SIZES")
    x_size = template_image.size[0]
    y_size = template_image.size[1]

    #text draw
    image_text = write_text(text_to_encode, template_image.size)
    bw_encode = image_text.convert('1')

    #encode text into image
    encoded_image = Image.new("RGB", (x_size, y_size))
    pixels = encoded_image.load()
    for i in range(x_size):
        for j in range(y_size):
            red_template_pix = bin(red_template.getpixel((i,j)))
            old_pix = red_template.getpixel((i,j))
            tencode_pix = bin(bw_encode.getpixel((i,j)))

            if tencode_pix[-1] == '1':
                red_template_pix = red_template_pix[:-1] + '1'
            else:
                red_template_pix = red_template_pix[:-1] + '0'
            pixels[i, j] = (int(red_template_pix, 2), green_template.getpixel((i,j)), blue_template.getpixel((i,j)))

    encoded_image.save("encoded_image.png")
    with open(filename, 'rb') as f:
        imgbyte = base64.b64encode(f.read())
    return imgbyte,200

@app.route("/decode",methods=['POST'])
def decode_image():
    try:
        # image_bytes = request.files.get('file').read()
        data = request.get_json()
        imgbyte = data['img']
        # print("BYTES: ",imgbyte)
        imgdata = base64.b64decode(imgbyte)
        filename = 'temp_img.png'
        with open(filename, 'wb') as f:
            f.write(imgdata)
    except:
        print("Error!")
        return "Some error occurred!"
        exit(0)
    
    encoded_image = Image.open('temp_img.png')

    red_channel = encoded_image.split()[0]

    x_size = encoded_image.size[0]
    y_size = encoded_image.size[1]

    decoded_image = Image.new("RGB", encoded_image.size)
    pixels = decoded_image.load()

    for i in range(x_size):
        for j in range(y_size):
            if bin(red_channel.getpixel((i, j)))[-1] == '0':
                pixels[i, j] = (255, 255, 255)
            else:
                pixels[i, j] = (0,0,0)
    decoded_image.save("decoded_image.png")
    filename = 'decoded_image.png'
    with open(filename, 'rb') as f:
        imgbyte = base64.b64encode(f.read())
    return imgbyte,200

if __name__ == "__main__":
    app.run(debug=True,host="0.0.0.0")
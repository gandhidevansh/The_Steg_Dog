# The Steg Dog

A simple image steganography flutter application based on RGB algorithm originally developed by [Pratik](https://github.com/PratikMante/Image-Steganography-in-Python).

## Working

### Front-End
- Developed using flutter.
- Contains an Encoding and a Decoding button on home screen.
- Feature to select picture from gallery or click-on-the-go and encode.
- A text box to enter the secret message to hide inside the image.
- Image converted to bytes and sent to server.
- Save the image.

### Back-End
- Developed on Python3. (Steg-Dog-Server)
- The algorithm stores the image on system and then does the processing. (This can be eliminated from code if required)
- Sends back the image as image bytes.

## Improvements that can be done

- Introducing mechanism for key generation and sharing can make the steganography way more secure. (or simply use a password for decryption for each image, this will need lots of reforming in code)
- Improving the UI functionalities.
- This is simple demonstration with no regard to threadings. Making the algorithm multithreaded for multiple users.
- Including the algorithm as flutter code itself rather than using a backend if possible. This can reduce time.

Example images after the processing are included inside the repository. (tron - original, encoded_image, decoded_image)

Feel free to use the code and improve it to next level :+1: Happy Coding!

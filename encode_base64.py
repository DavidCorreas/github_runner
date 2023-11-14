import base64

def encode_base64(input_string):
    # Convert string to bytes
    message_bytes = input_string.encode('utf-8')
    # Encode the bytes
    base64_bytes = base64.b64encode(message_bytes)
    # Convert back to string
    base64_string = base64_bytes.decode('utf-8')
    return base64_string

def decode_base64(base64_string):
    # Convert base64 string to bytes
    base64_bytes = base64_string.encode('utf-8')
    # Decode the base64 bytes
    message_bytes = base64.b64decode(base64_bytes)
    # Convert back to string
    message = message_bytes.decode('utf-8')
    return message

# Example usage
original_string = "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"
encoded_string = encode_base64(original_string)
decoded_string = decode_base64(encoded_string)

print(f"Original: {original_string}")
print(f"Encoded: {encoded_string}")
print(f"Decoded: {decoded_string}")

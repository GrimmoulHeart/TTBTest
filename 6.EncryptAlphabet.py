def decrypt_string(encrypted_str, k):
    decrypted_str = []

    for char in encrypted_str:
        char_index = ord(char) - ord('A')
        new_index = (char_index - k) % 26
        decrypted_char = chr(new_index + ord('A'))
        decrypted_str.append(decrypted_char)

    return ''.join(decrypted_str)

encrypted_str = "VTAOG"
k = 2
decrypted_str = decrypt_string(encrypted_str, k)
print(f"Encrypted: {encrypted_str}")
print(f"Decrypted: {decrypted_str}")
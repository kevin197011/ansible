package main

import (
    "fmt"

    "github.com/sosedoff/ansible-vault-go"
)

func main() {
    // // Encrypt secret data
    // str, err := vault.Encrypt("secret", "password")
    // if err != nil {
    //     panic(err)
    // }
    // fmt.Println("encrypted data:", str)

    // // Decrypt secret data encrypted in the previos step
    // str, err = vault.Decrypt(str, "password")
    // if err != nil {
    //     panic(err)
    // }
    // fmt.Println("decrypted data:", str)

    // Write secret data to file
    // err = vault.EncryptFile("/tmp/vault", "secret", "password")
    // if err != nil {
    //     panic(err)
    // }

    // Read existing secret
    str, err := vault.DecryptFile("../secrets/secrets.yml", "12345678")
    if err != nil {
        panic(err)
    }
    fmt.Println("decrypted file:\n", str)
}
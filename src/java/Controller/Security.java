/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.*;


/**
 *
 * @author csean
 */
public class Security {
    
        private static byte[] key; //Google Translate: It's really a pain to take care of yourself.
        private static byte[] initVector; //exactly 16 bytes for 256 bit encryption
        
        private String algorithm;
        private String mode;
        private String transformation;
        
        public Security(String key) {
            this.key = key.getBytes();
            this.algorithm = "AES";
            this.mode = "ECB";
            this.transformation = String.format("%s/%s/PKCS5Padding",algorithm,mode);
        }
        
        public Security(String key, String initVector) {
            this.key = key.getBytes();
            this.initVector = initVector.getBytes();
            this.algorithm = "AES";
            this.mode = "CBC";
            this.transformation = String.format("%s/%s/PKCS5Padding",algorithm,mode);
        }
        
        public Security(String key, String initVector, String mode) {
            this.key = key.getBytes();
            this.initVector = initVector.getBytes();
            this.algorithm = "AES";
            this.mode = mode;
            this.transformation = String.format("%s/%s/PKCS5Padding",algorithm,mode);
        }
        
        public Security(String key, String initVector, String algorithm, String mode) {
            this.key = key.getBytes();
            this.initVector = initVector.getBytes();
            this.algorithm = algorithm;
            this.mode = mode;
            this.transformation = String.format("%s/%s/PKCS5Padding",algorithm,mode);
        }
        
        public String getAlgorithm() {
            return algorithm;
        }
        
        public String getMode() {
            return mode;
        }
        
        public String getTransformation() {
            return transformation;
        }
        
        
        public String encrypt(String plaintext) {
            String ciphertext = null;
            try
            {
                Cipher cipher = Cipher.getInstance(this.getTransformation());
                final SecretKeySpec secretKey = new SecretKeySpec(key,this.getAlgorithm()); //makes the secretKey an AES key
                if (this.getMode().equals("ECB"))
                    cipher.init(Cipher.ENCRYPT_MODE, secretKey);
                else
                {
                    IvParameterSpec iv = new IvParameterSpec(initVector);
                    cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
                }
                ciphertext = Base64.encodeBase64String(cipher.doFinal(plaintext.getBytes()));
            }
            catch (Exception e)
            {
                System.err.println(e.getMessage());
            }
            return ciphertext;
        }
        
        public String decrypt(String ciphertext) {
            String plaintext = null;
            try
            {
                Cipher cipher = Cipher.getInstance(this.getTransformation());
                final SecretKeySpec secretKey = new SecretKeySpec(key, this.getAlgorithm());
                if (this.getMode().equals("ECB"))
                    cipher.init(Cipher.DECRYPT_MODE, secretKey);
                else
                {
                    IvParameterSpec iv = new IvParameterSpec(initVector);
                    cipher.init(Cipher.DECRYPT_MODE, secretKey,iv);
                }
                plaintext = new String(cipher.doFinal(Base64.decodeBase64(ciphertext))); //from Base64.encodeBase64String(cipher.doFinal(ciphertext.getBytes()));
            }
            catch (Exception e)
            {
                System.err.println(e.getMessage());
            }
            return plaintext;
        }
}

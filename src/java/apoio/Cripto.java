package apoio;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class Cripto {

    public static String criptografar(String senha) {

        try {
            return Base64.getEncoder().encodeToString(MessageDigest.getInstance("SHA-512").digest(senha.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException ex) {
            return null;
        }
    }

    public static boolean eIgual(String hash, String senha) {
        String senhaHash = criptografar(senha);
        if (senhaHash == null) {
            return false;
        }
        return hash.equals(senhaHash);
    }

}

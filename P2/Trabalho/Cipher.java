package Trabalho;

import java.util.Scanner;
//import java.lang.Character;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.regex.Pattern;

public class Cipher {

    private static String normalize(String naturalText) {
        String noAccentString =                                                         //retira os acentos da string
            Normalizer
                .normalize(naturalText, Normalizer.Form.NFD)
                .replaceAll("[^\\p{ASCII}]", "");
        String noSpaceString = noAccentString.replaceAll("\\s+", "");                   //retira os espaços entre as palavras da string
        String noPunctString = noSpaceString.replaceAll("\\p{Punct}", "");              //retira os sinais de pontuação da string
        String normalString = noPunctString.toLowerCase();                              //coloca todas as letras da string minúsculas
        return normalString;
    }
    
    public static String encode(String plainText, int cols) {
        String normalize = Cipher.normalized(plainText);
        boolean c = normalize.length() % cols != 0;
        String randomText = "";
        StringBuilder code = new StringBuilder();
        if(c) {
            Random x = new Random();
            for(int i=normalize.length()%cols; i!=cols; i++) randomText += (char)(x.nextInt(26) + 'a');
        }
        int i = 0;
        int column = 0;
        while(column < cols) {
            if(i < normalize.length()) {
                code.append(normalize.charAt(i));
                i += cols;
            }
            else {
                column++;
                i = column;
            }
        }
        code.append(randomText);
        return code.toString();
    }
}

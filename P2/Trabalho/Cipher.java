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


    public static void main(String[] args) {
        String naturalText = "Sou o Pussycólogo, da Pussyologia!!!";
        System.out.println(Cipher.normalize(naturalText));
    }
}

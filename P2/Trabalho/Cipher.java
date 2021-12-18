import java.text.Normalizer;
import java.util.Random;
import java.util.ArrayList;
import java.util.List;

public class Cipher {

    private static String normalize(String naturalText) {                               //alínea 1
        String noAccentString =                                                         //retira os acentos da string
            Normalizer
                .normalize(naturalText, Normalizer.Form.NFD)
                .replaceAll("[^\\p{ASCII}]", "");
        String noSpaceString = noAccentString.replaceAll("\\s+", "");                   //retira os espaços entre as palavras da string
        String noPunctString = noSpaceString.replaceAll("\\p{Punct}", "");              //retira os sinais de pontuação da string
        String normalString = noPunctString.toLowerCase();                              //coloca todas as letras da string minúsculas
        return normalString;
    }
    
    public static String encode(String plainText, int cols) {                           //alínea 2
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
    
    public static List<Integer> findDividers(int n) {               //alínea 3
        List<Integer> divs = new ArrayList<Integer>();              //cria uma lista para os divisores da variável n
        for(int i=1; i<=n; i++) {                                   //neste ciclo for, a variável i percorre todos os inteiros até n (inclusivé)
            if(n % i == 0)                                          // se a divisão de n por i der resto 0, então i é divisor de n
                divs.add(i);
        }
        return divs;                                                //retorna a lista de inteiros já com os divisores de n
    }
}

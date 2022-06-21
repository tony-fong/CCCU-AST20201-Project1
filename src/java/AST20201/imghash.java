/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AST20201;
import java.util.*;
/**
 *
 * @author tonyf
 */
public class imghash {
    String file;
    public String imgname(String filename){
           
        Random random = new Random();
        
        String name = filename;
        String hash = "";
        
         char[] arr = new char[name.length()];
        for(int i=0;i<name.length();i++){
            if(name.charAt(i) != 46 && name.charAt(i) != 'j' && name.charAt(i) != 'p' && name.charAt(i) != 'g' 
                   && name.charAt(i) != 'J' && name.charAt(i) != 'P' && name.charAt(i) != 'G'){
                arr[i] = name.charAt(i);
            }
        }
        for(int i=0;i < arr.length;i++){
            int times = random.nextInt(1500 - 1000 + 1) + 1000;
            int ascii = arr[i] * times % 100;
            System.out.println(ascii);
            if(ascii >= 65 && ascii <= 90 || ascii >= 97 && ascii <= 122){
                hash = hash + (char)ascii;
            }   
        }
        while(hash.length() < 8){
            int num = random.nextInt(15000 - 10000 + 1) + 10000;
            int times = random.nextInt(1500 - 1000 + 1) + 1000;
            int ascii = num * times % 1000;
            System.out.println(ascii);
            if(ascii >= 65 && ascii <= 90 || ascii >= 97 && ascii <= 122){
                hash = hash + (char)ascii;
            }
        }
        hash =  hash + ".jpg";
        return hash;
    }

}

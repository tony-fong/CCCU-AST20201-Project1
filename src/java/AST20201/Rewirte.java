/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AST20201;

/**
 *
 * @author tonyf
 */
public class Rewirte {
    public String rewrite(String _filepath){
        String temp =  _filepath;
        String filepath = "";
        char[] ch = new char[temp.length() + 1];
        for(int j=0 ; j<temp.length() ;j++){
           ch[j] = temp.charAt(j);
        }
        for(int j=0 ; j<temp.length();j++){
           if(j == 2){
               filepath = filepath + ch[j];
               filepath = filepath + "/";
           }else{
               filepath = filepath + ch[j];
           }
       }
        return filepath;
    }
  

}

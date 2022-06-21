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
public class userhash {
    public int idHash(String username){
        int hash = 0;
        char[] arr = new char[username.length()];
        for(int i=0;i<username.length();i++){
            arr[i] = username.charAt(i);
        }
        for(int i=0;i < arr.length;i++){
            hash = hash + arr[i];
        }
        return hash;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AST20201;
import java.util.*;
import java.util.ArrayList;
import java.io.*;
/**
 *
 * @author tonyf
 */
public class Cartdata {
    private ArrayList<String> seller_id = new ArrayList<String>();
    private ArrayList<String> price = new ArrayList<String>();
    private ArrayList<String> product_id = new ArrayList<String>();
    private ArrayList<String> product_name = new ArrayList<String>();
    private ArrayList<String> number = new ArrayList<String>();
    private ArrayList<String> local = new ArrayList<String>();
    private ArrayList<String> seller_name = new ArrayList<String>();
    
    public void setSellerId(String sellerId){
        seller_id.add(sellerId);
    }
    public void setPrice(String product_price){
        price.add(product_price);
    }
    public void setProductId(String _product_id){
        product_id.add(_product_id);
    }
    public void setNumber(String _number){
        number.add(_number);
    }
    public void setLocal(String _local){
        local.add(_local);
    }
    public void setSellerName(String _seller_name){
        seller_name.add(_seller_name);
    }
    public void setProductName(String name){
        product_name.add(name);
    }
    
    
    public ArrayList<String> getSellerId(){
        return seller_id;
    }
    public ArrayList<String> getPrice(){
        return price;
    }
    public ArrayList<String> getProductId(){
        return product_id;
    }
    public ArrayList<String> getNumber(){
        return number;
    }
    public ArrayList<String> getLocal(){
        return local;
    }
    public ArrayList<String> getSellerName(){
        return seller_name;
    }
    public ArrayList<String> getProductName(){
        return product_name;
    }
    public void clear(){
        seller_id.clear();
        price.clear();
        product_id.clear();
        number.clear();
        local.clear();
        seller_name.clear();
        product_name.clear();
    }
}

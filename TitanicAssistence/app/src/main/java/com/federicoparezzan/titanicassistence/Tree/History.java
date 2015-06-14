package com.federicoparezzan.titanicassistence.Tree;

import android.content.Context;

import java.util.ArrayList;

/**
 * Created by federicoparezzan on 14/06/15.
 */
public class History {

    private ArrayList<Node> arrayList;
    private static History instance;



    public History(){
        arrayList = new ArrayList<>();
    }


    public static History getInstance(){
        if (instance==null)
        {
            instance= new History() ;
        }
        return instance;
    }

    public void addNode(Node node){
        arrayList.add(node);
    }

    public void removeNode(){
        arrayList.remove(arrayList.size() - 1);
    }

    public void removeAllNode(){
        arrayList.removeAll(arrayList);
    }

    public String createCode(){
        String code = new String();
        int cont = 0;

        for (Node n: arrayList){
            if (cont < arrayList.size() -1 ) {
                code += n.getCode().getTipologia() + "-";
            } else {
                code += n.getCode().getTipologia();
            }
            cont ++;
        }
        return  code;
    }


}

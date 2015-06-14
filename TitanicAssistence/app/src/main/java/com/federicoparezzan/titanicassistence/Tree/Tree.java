package com.federicoparezzan.titanicassistence.Tree;

import android.content.Context;

import com.federicoparezzan.titanicassistence.Bean.ProblemBean;
import com.federicoparezzan.titanicassistence.Persistence.ProblemPersistence;
import com.federicoparezzan.titanicassistence.Util.MyAppSubclass;
import com.federicoparezzan.titanicassistence.Util.Utils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by federicoparezzan on 11/06/15.
 */
public class Tree{

    public static final String TAG = "Tree class";

    private static Tree instance;
    private static MyAppSubclass myAppSubclass;

    private Node root;

    public Node getRoot() {
        return root;
    }

    public void setRoot(Node root) {
        this.root = root;
    }

    private Tree(Context context){
        myAppSubclass = (MyAppSubclass) context.getApplicationContext();
        List<ProblemBean> codes = Tree.buildCodes();
        List<Node> nodes = Tree.buildNodes(codes);

         root = nodes.get(nodes.size()-3);

        for (Node n : nodes) {
            for (int i = 0; i < nodes.size(); i++) {
                if (nodes.get(i).getCode().getTipologia().startsWith(n.getCode().getTipologia())
                        && nodes.get(i).getCode().getTipologia().length() == n.getCode().getTipologia().length() + 1) {

                    n.getChildren().add(nodes.get(i));
                }
            }
        }
        if (Utils.USE_DEBUG) {
            printTree(root);
        }
    }

    public static Tree getInstance(Context context){
        if (instance==null)
        {
            instance= new Tree(context) ;
        }
        return instance;

    }


    private static void printTree(Node n) {
        if (n != null) {
            System.out.println(n.toString());

            for (Node c : n.getChildren()) {
                Tree.printTree(c);
            }
        }
    }

    /**
     *  Metodo che crea una lista di Node
     * @param codes
     * @return
     */
    private static List<Node> buildNodes(List<ProblemBean> codes) {

        List<Node> nodes = null;

        nodes = new ArrayList<>();

        for (ProblemBean s : codes) {
            nodes.add(new Node(new ArrayList<Node>(), s));
        }

        return nodes;
    }

    /**
     * Metodo che con un'interrogazione alla bdd recupera tutti i problemi
     * @return codes --> una lista di ProblemBean
     */
    private static List<ProblemBean> buildCodes() {

        List<ProblemBean> codes = null;

        codes = new ArrayList<>();

        ProblemBean problemBean = new ProblemBean();

        codes = ProblemPersistence.loadAll(myAppSubclass.getDbPath());

        return codes;
    }



}

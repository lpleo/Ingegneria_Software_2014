package com.federicoparezzan.titanicassistence.Memento;

import com.federicoparezzan.titanicassistence.Tree.Node;

/**
 * Created by federicoparezzan on 12/06/15.
 */
public class Originator {

    private Node originatorState;
    private static Originator instance;
    private Memento memento;

    public Originator(){
    }


    public static Originator getInstance()
    {
        if (instance==null)
        {
            instance= new Originator() ;
        }
        return instance;
    }

    public void setOriginatorState(Node state) {
        originatorState = state;
    }

    public Node getOriginatorState() {
        return originatorState;
    }

    public void createMemento() {
        memento = new Memento();
        memento.setMementoState(originatorState);
    }

    public Memento createMemento(Node node){
        memento = new Memento();
        memento.setMementoState(node);
        return  memento;
    }

    public void restoreMemento(Memento memento) {
        originatorState = memento.getMementoState();
    }

    public void restoreMemento() {
        originatorState = memento.getMementoState();
    }
}

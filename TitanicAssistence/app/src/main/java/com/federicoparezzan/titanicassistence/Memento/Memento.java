package com.federicoparezzan.titanicassistence.Memento;


import com.federicoparezzan.titanicassistence.Tree.Node;

/**
 * Created by federicoparezzan on 12/06/15.
 */
public class Memento {

    private Node mementoState;

    protected Node getMementoState() {
        return this.mementoState;
    }

    protected void setMementoState(Node originatorState) {
        this.mementoState = originatorState;
    }

}

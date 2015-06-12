package com.federicoparezzan.titanicassistence.Tree;

import com.federicoparezzan.titanicassistence.Bean.ProblemBean;

import java.util.List;

public class Node {

    private List<Node> children;
    private ProblemBean code;


    /**
     *
     * @param children
     * @param code
     */
    public Node(List<Node> children, ProblemBean code) {
        this.children = children;
        this.code = code;
    }

    public List<Node> getChildren() {
        return children;
    }

    public void setChildren(List<Node> children) {
        this.children = children;
    }

    public ProblemBean getCode() {
        return code;
    }

    public void setCode(ProblemBean code) {
        this.code = code;
    }

    /**
     * Metodo usato per il debug. Non si sa mai ;)
     * @return
     */
    @Override
    public String toString() {

        StringBuilder b = new StringBuilder();

        b.append("Io sono il nodo ").append(this.getCode()).append("\n");

        if (!this.getChildren().isEmpty()) {
            b.append("I miei figli sono: ");

            for (Node n : this.getChildren()) {
                b.append(n.getCode()).append("; ");
            }
        } else {
            b.append("Non ho figli.");
        }

        b.append("\n");

        return b.toString();
    }
}

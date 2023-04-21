package csymbol;

import java.util.ArrayList;

public class CDeclList {
    ArrayList<CDecl> decls;

    public CDeclList(CDecl first) {
        decls = new ArrayList<CDecl>();
        decls.add(first);
    }

    public CDeclList add(CDecl decl) {
        decls.add(decl);
        return this;
    }

    public CDecl first() {
        return decls.get(0);
    }

    public String toString() {
        String result = "";
        for (CDecl decl : decls) {
            result += decl.toString();
            result += ", ";
        }
        return result.substring(0, result.length() - 2);
    }
}

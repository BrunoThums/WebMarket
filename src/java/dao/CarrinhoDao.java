package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Carrinho;
import java.util.ArrayList;
import java.sql.*;

public class CarrinhoDao implements IDAO<Carrinho> {

    ResultSet result;

    @Override
    public String salvar(Carrinho o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO carrinho "
                    + "default,"
                    + "'" + o.quant + "',"
                    + "'" + o.precoTotal + "',"
                    + "'" + o.id_produto + "',"
                    + "'now()'";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar o carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Carrinho o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE carrinho SET "
                    + "quant=" + o.quant + ","
                    + "precoTotal=" + o.precoTotal + ","
                    + "id_produto=" + o.id_produto + " "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Carrinho> consultarTodos() {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean registroUnico(Carrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Carrinho> consultar(String criterio) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Carrinho consultarId(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean consultar(Carrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

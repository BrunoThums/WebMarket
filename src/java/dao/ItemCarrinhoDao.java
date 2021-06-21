package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.ItemCarrinho;
import java.util.ArrayList;
import java.sql.*;


public class ItemCarrinhoDao implements IDAO<ItemCarrinho> {

    ResultSet result;

    @Override
    public String salvar(ItemCarrinho item) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO itemCarrinho VALUES "
                    + "(default,"
                    + "'" + item.quant + "',"
                    + "'" + item.valorUnit + "',"
                    + "'" + item.id_produto + "',"
                    + "'now()')";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar o item do carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(ItemCarrinho o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE itemCarrinho SET "
                    + "quant=" + o.quant + ","
                    + "valorUnit=" + o.valorUnit + ","
                    + "id_produto=" + o.id_produto + " "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar item do carrinho: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<ItemCarrinho> consultarTodos() {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean registroUnico(ItemCarrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<ItemCarrinho> consultar(String criterio) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ItemCarrinho consultarId(int id) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean consultar(ItemCarrinho o) {//não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

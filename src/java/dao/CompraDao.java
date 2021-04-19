package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Compra;
import entidade.Venda;
import java.util.ArrayList;
import java.sql.*;

public class CompraDao implements IDAO<Compra> {

    ResultSet result;

    @Override
    public String salvar(Compra o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO compra"
                    + "default,"
                    + "'" + o.valor + "',"
                    + "'" + o.parcelas + "',"
                    + "'" + o.id_pessoa + "',"
                    + "'" + o.id_carrinho + "'";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar compra" + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Compra o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE compra SET "
                    + "valor=" + o.valor + ","
                    + "parcelas=" + o.parcelas + ","
                    + "id_pessoa=" + o.id_pessoa + ","
                    + "id_carrinho=" + o.id_carrinho + " "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar compra: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) { //não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Compra> consultarTodos() {
        String sql = "SELECT * FROM compra ";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Compra> compra = new ArrayList<>();
            while (result.next()) {
                compra.add(Compra.from(result));
            }
            if (compra.isEmpty()) {
                return null;
            }
            return compra;
        } catch (Exception e) {
            System.out.println("Erro ao consultar compras: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Compra o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Compra> consultar(String criterio) {
        String sql = "SELECT * FROM compra WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Compra> compra = new ArrayList<>();
            while (result.next()) {
                compra.add(Compra.from(result));
            }
            if (compra.isEmpty()) {
                return null;
            }
            return compra;
        } catch (Exception e) {
            System.out.println("Erro ao consultar compras: " + e);
        }
        return null;
    }

    @Override
    public Compra consultarId(int id) {
        String sql = "SELECT * FROM compra WHERE id=" + id;
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Compra.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar compra por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Compra o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

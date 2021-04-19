package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Venda;
import java.util.ArrayList;
import java.sql.*;

public class VendaDao implements IDAO<Venda> {

    ResultSet result;

    @Override
    public String salvar(Venda o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO venda"
                    + "default,"
                    + "'" + o.valor + "',"
                    + "'" + o.parcelas + "',"
                    + "'" + o.id_pessoa + "',"
                    + "'" + o.id_carrinho + "'";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar venda" + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Venda o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE venda SET "
                    + "valor=" + o.valor + ","
                    + "parcelas=" + o.parcelas + ","
                    + "id_pessoa=" + o.id_pessoa + ","
                    + "id_carrinho=" + o.id_carrinho + " "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar venda: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) { //não é necessário
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Venda> consultarTodos() {
        String sql = "SELECT * FROM venda ";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Venda> venda = new ArrayList<>();
            while (result.next()) {
                venda.add(Venda.from(result));
            }
            if (venda.isEmpty()) {
                return null;
            }
            return venda;
        } catch (Exception e) {
            System.out.println("Erro ao consultar vendas: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Venda o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Venda> consultar(String criterio) {
        String sql = "SELECT * FROM venda WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Venda> venda = new ArrayList<>();
            while (result.next()) {
                venda.add(Venda.from(result));
            }
            if (venda.isEmpty()) {
                return null;
            }
            return venda;
        } catch (Exception e) {
            System.out.println("Erro ao consultar vendas: " + e);
        }
        return null;
    }

    @Override
    public Venda consultarId(int id) {
        String sql = "SELECT * FROM venda WHERE id=" + id;
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Venda.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar vendas por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Venda o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

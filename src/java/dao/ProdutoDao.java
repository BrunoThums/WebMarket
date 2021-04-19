package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Produto;
import java.sql.*;
import java.util.ArrayList;

public class ProdutoDao implements IDAO<Produto> {

    ResultSet result;

    @Override
    public String salvar(Produto o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO produto VALUES"
                    + "default,"
                    + "'" + o.descricao + "',"
                    + "'" + o.valor + "',"
                    + "'" + o.estoque + "',"
                    + "'" + o.unidade + "',"
                    + "'" + o.id_categoria + "',"
                    + "'" + o.ativo + "',"
                    + " 'now()',"
                    + "' null '";

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;
        } catch (Exception e) {
            System.out.println("Erro ao salvar produto: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Produto o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE produto SET "
                    + "descricao=" + o.descricao + ","
                    + "valor=" + o.valor + ","
                    + "quantidade=" + o.estoque + ","
                    + "unidade=" + o.unidade + ","
                    + "id_categoria=" + o.id_categoria + ","
                    + "ativo=" + o.ativo + " "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar produto: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE produto SET ativo = N WHERE id=" + id;
            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao excluir produto: " + e);
            return e.toString();
        }
    }
    
    public ArrayList<Produto> consultarTodos() {
        String sql = "SELECT * FROM produto WHERE status <> N";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Produto> produto = new ArrayList<>();
            while (result.next()) {
                produto.add(Produto.from(result));
            }
            if (produto.isEmpty()) {
                return null;
            }
            return produto;
        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Produto o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Produto> consultar(String criterio) {
        String sql = "SELECT * FROM produto WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Produto> produto = new ArrayList<>();
            while (result.next()) {
                produto.add(Produto.from(result));
            }
            if (produto.isEmpty()) {
                return null;
            }
            return produto;
        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos: " + e);
        }
        return null;
    }

    @Override
    public Produto consultarId(int id) {
    String sql = "SELECT * FROM produto WHERE id=" + id;
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Produto.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Produto o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

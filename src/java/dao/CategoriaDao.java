package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Categoria;
import java.sql.*;
import java.util.ArrayList;

public class CategoriaDao implements IDAO<Categoria> {

    ResultSet result;

    @Override
    public String salvar(Categoria cat) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO categoria VALUES"
                    + "(default,"
                    + "'" + cat.descricao + "',"
                    + " now(),"
                    + " now(),"
                    + "'" + cat.ativo + "')";

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao salvar categoria: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Categoria categoria) {
        String saida = null;

        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE categoria SET"
                    + "descricao = " + categoria.descricao + ","
                    + "atualizado_em = 'now()' "
                    + "WHERE id = '" + categoria.id + "'";

            int retorno = stm.executeUpdate(sql);

            if (retorno != 0) {
                saida = null;
            } else {
                saida = "Erro";
            }
        } catch (Exception e) {
            System.out.println("Erro ao salvar a categoria: " + e);
            saida = e.toString();
        }

        return saida;
    }

    @Override
    public String excluir(int id) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE categoria SET ativo = 'N' WHERE id=" + id;
            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao excluir categoria: " + e);
            return e.toString();
        }
    }

    @Override
    public ArrayList<Categoria> consultarTodos() {
        String sql = "SELECT * FROM categoria WHERE ativo = 'Y'";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Categoria> categoria = new ArrayList<>();
            while (result.next()) {
                categoria.add(Categoria.from(result));
            }
            if (categoria.isEmpty()) {
                return null;
            }
            return categoria;
        } catch (Exception e) {
            System.out.println("Erro ao consultar categoria: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Categoria o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Categoria> consultar(String criterio) {
        String sql = "SELECT * FROM categoria WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Categoria> categoria = new ArrayList<>();
            while (result.next()) {
                categoria.add(Categoria.from(result));
            }
            if (categoria.isEmpty()) {
                return null;
            }
            return categoria;
        } catch (Exception e) {
            System.out.println("Erro ao consultar categorias: " + e);
        }
        return null;
    }

    @Override
    public Categoria consultarId(int id) {
        String sql = "SELECT * FROM categoria WHERE id=" + id;
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Categoria.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar categorias por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Categoria o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

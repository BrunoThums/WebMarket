package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Fornecedor;
import entidade.Pessoa;
import java.util.ArrayList;
import java.sql.*;

public class FornecedorDao implements IDAO<Fornecedor> {

    ResultSet result;

    @Override
    public String salvar(Fornecedor o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO fornecedor values"
                    + "(default,"
                    + "'" + o.nome + "',"
                    + "'" + o.email + "',"
                    + "'" + o.endereco + "',"
                    + "'" + o.telefone + "',"
                    + "'" + o.ativo + "',"
                    + "'now()',"
                    + "'now()')";

            System.out.println("SQL: " + sql);

            int retorno = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao salvar fornecedor: " + e);
            return e.toString();
        }
    }

    @Override
    public String atualizar(Fornecedor o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE fornecedor SET "
                    + "descricao=" + o.nome + ","
                    + "quantidade=" + o.email + ","
                    + "unidade=" + o.endereco + ","
                    + "id_categoria=" + o.telefone + ","
                    + "ativo=" + o.ativo + ","
                    + "'now()' "
                    + "WHERE id= " + o.id;

            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao atualizar fornecedor: " + e);
            return e.toString();
        }
    }

    @Override
    public String excluir(int id) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "UPDATE fornecedor SET ativo = N WHERE id=" + id;
            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao excluir fornecedor: " + e);
            return e.toString();
        }
    }

    @Override
    public ArrayList<Fornecedor> consultarTodos() {
        String sql = "SELECT * FROM fornecedor WHERE status <> N";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Fornecedor> fornecedor = new ArrayList<>();
            while (result.next()) {
                fornecedor.add(Fornecedor.from(result));
            }
            if (fornecedor.isEmpty()) {
                return null;
            }
            return fornecedor;
        } catch (Exception e) {
            System.out.println("Erro ao consultar fornecedores: " + e);
        }
        return null;
    }

    @Override
    public boolean registroUnico(Fornecedor o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Fornecedor> consultar(String criterio) {
        String sql = "SELECT * FROM fornecedor WHERE '%" + criterio + "%' ORDER BY descricao";
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            ArrayList<Fornecedor> fornecedor = new ArrayList<>();
            while (result.next()) {
                fornecedor.add(Fornecedor.from(result));
            }
            if (fornecedor.isEmpty()) {
                return null;
            }
            return fornecedor;
        } catch (Exception e) {
            System.out.println("Erro ao consultar fornecedores: " + e);
        }
        return null;
    }

    @Override
    public Fornecedor consultarId(int id) {
        String sql = "SELECT * FROM fornecedor WHERE id=" + id;
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            if (result.next()) {
                return Fornecedor.from(result);
            }

        } catch (Exception e) {
            System.out.println("Erro ao consultar fornecedor por ID: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Fornecedor o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}


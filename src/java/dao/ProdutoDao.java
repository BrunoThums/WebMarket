package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Produto;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

public class ProdutoDao implements IDAO<Produto> {

    ResultSet result;

    @Override
    public String salvar(Produto o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO produto VALUES "
                    + "(default,"
                    + "'" + o.descricao + "',"
                    + "'" + o.valor + "',"
                    + "'" + o.estoque + "',"
                    + "'" + o.id_categoria + "',"
                    + "'" + o.ativo + "',"
                    + " now(),"
                    + " now(),"
                    + "'" + o.nome + "',"
                    + "'" + o.file + "'"
                    + ")";

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
                    + "descricao='" + o.descricao + "',"
                    + "nome ='" + o.nome + "', "
                    + "valor='" + o.valor + "',"
                    + "estoque='" + o.estoque + "',"
                    + "id_categoria='" + o.id_categoria + "',"
                    + "ativo='" + o.ativo + "', "
                    + "updated_at= now()";
            System.out.println(o.file);
            if (o.file == null || o.file.length() >= 0) {
                sql += ", file = '" + o.file + "'"
                        + " WHERE id= " + o.id;
            } else {
                sql += " WHERE id = " + o.id;
            }

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

            String sql = "UPDATE produto SET ativo = false WHERE id=" + id;
            System.out.println("SQL: " + sql);

            int resultado = stm.executeUpdate(sql);

            return null;

        } catch (Exception e) {
            System.out.println("Erro ao excluir produto: " + e);
            return e.toString();
        }
    }

    @Override
    public ArrayList<Produto> consultarTodos() {
        String sql = "SELECT * FROM produto";
        try {
            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
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
        return consultarProdAndCategAndPreco(criterio, null, null);
    }

    public ArrayList<Produto> consultarProdAndCategAndPreco(String pesquisa, String id_categoria, String valor) {
        String sql = "SELECT * "
                + "FROM produto p "
                + "WHERE p.nome ILIKE '%" + pesquisa + "%' ";

        if (id_categoria != null && id_categoria.matches("^\\d+$")) {
            sql += " AND p.id_categoria =" + id_categoria;
        }
        if (valor != null && valor.matches("^\\d+$") && Integer.parseInt(valor) > 0) {
            sql += " AND valor > " + valor;
        }
        ArrayList<Produto> produto = new ArrayList<>();

        try {

            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            while (result.next()) {
                produto.add(Produto.from(result));
            }
            return produto;
        } catch (Exception e) {
            System.out.println("Erro ao consultar produtos com categorias: " + e);
        }
        return produto;
    }

    @Override
    public Produto consultarId(int id) {
        String sql = "SELECT * FROM produto WHERE id=" + id;
        try {
            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
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

    public byte[] gerarRelatorio(String ativo) {
        try {
            Connection conn = ConexaoBD.getInstance().getConnection();

            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/ListaProduto.jrxml"));

            Map parameters = new HashMap();
            parameters.put("ativo", ativo);

            byte[] bytes = JasperRunManager.runReportToPdf(relatorio, parameters, conn);

            return bytes;
        } catch (Exception e) {
            System.out.println("erro ao gerar relatorio: " + e);
        }
        return null;
    }

    public byte[] gerarRelatorioValor(Double valorIni, Double valorFinal) {
        try {
            Connection conn = ConexaoBD.getInstance().getConnection();

            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/RelatorioDePrecos.jrxml"));

            Map parameters = new HashMap();
            parameters.put("valorIni", valorIni);
            parameters.put("valorFinal", valorFinal);
           

            byte[] bytes = JasperRunManager.runReportToPdf(relatorio, parameters, conn);

            return bytes;
        } catch (Exception e) {
            System.out.println("erro ao gerar relatorio: " + e);
        }
        return null;
    }

}

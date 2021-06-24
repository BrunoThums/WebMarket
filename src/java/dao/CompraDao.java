package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Compra;
import java.util.ArrayList;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

public class CompraDao implements IDAO<Compra> {

    ResultSet result;

    @Override
    public String salvar(Compra o) {
        try {
            Statement stm = ConexaoBD.getInstance().getConnection().createStatement();

            String sql = "INSERT INTO compra VALUES "
                    + "(default,"
                    + "'" + o.valorTotal + "',"
                    + "'" + o.parcelas + "',"
                    + "'" + o.id_pessoa + "',"
                    + " now(),"
                    + " now())";

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
                    + "valorTotal=" + o.valorTotal + ","
                    + "parcelas=" + o.parcelas + ","
                    + "id_pessoa=" + o.id_pessoa + " "
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

    public ArrayList<Compra> consultaAvancada(String nome) {
        String sql = "";
        if (nome == null || nome.isEmpty()) {
            sql = "SELECT * "
                    + "FROM compra ORDER BY created_at";
        } else {
            sql
                    = "SELECT * "
                    + "FROM compra, pessoa "
                    + "WHERE pessoa.id=compra.id_pessoa "
                    + "  AND pessoa.nome ILIKE '%" + nome + "%' "
                    + "ORDER BY compra.created_at";
        }
        ArrayList<Compra> compra = new ArrayList<>();

        try {

            result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
            while (result.next()) {
                compra.add(Compra.from(result));
            }
            return compra;
        } catch (Exception e) {
            System.out.println("Erro na consulta avançada: " + e);
        }
        return compra;
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

    public byte[] gerarRelatorioData(String nome, String dataIni, String dataFim) {
        try {
            Connection conn = ConexaoBD.getInstance().getConnection();

            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/relatorio_compra.jrxml"));

            Map parameters = new HashMap();
            parameters.put("nome", nome);
            parameters.put("dataIni", Date.valueOf(dataIni));
            parameters.put("dataFim", Date.valueOf(dataFim));

            byte[] bytes = JasperRunManager.runReportToPdf(relatorio, parameters, conn);

            return bytes;
        } catch (Exception e) {
            System.out.println("erro ao gerar relatorio: " + e);
        }
        return null;
    }

    @Override
    public boolean consultar(Compra o) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

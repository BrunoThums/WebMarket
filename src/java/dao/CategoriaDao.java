package dao;

import apoio.ConexaoBD;
import apoio.IDAO;
import entidade.Categoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.swing.JOptionPane;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

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

            String sql = "UPDATE categoria SET "
                    + "descricao='" + categoria.descricao + "',"
                    + "updated_at='now()', "
                    + "ativo='"+categoria.ativo+"' "
                    + "WHERE id='" + categoria.id + "'";

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
        String sql = "SELECT * FROM categoria WHERE descricao ILIKE '%" + criterio + "%' ORDER BY descricao";
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
    
    public ArrayList<Categoria> consultaAvancada(String busca, String ativo) {
        
        String sql = "SELECT * FROM categoria WHERE descricao ILIKE '%" + busca + "%' AND ativo = '"+ativo+"' ORDER BY descricao";
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

    private ArrayList<Categoria> pesquisa(String criterio, String dataIni, String dataFim, String status, String ordem) {
        String pesquisa = "SELECT * FROM "
                + "categoria c, "
                + "WHERE c.status = '" + status + "' ";
        if (criterio != null && !criterio.isEmpty()) {
            pesquisa += "AND ("
                    + "c.descricao ILIKE '%" + criterio + "%');";
        }
        if ((dataIni != null && !dataIni.isEmpty()) && (dataFim != null && !dataFim.isEmpty())) {
            pesquisa += " AND data BETWEEN '" + dataIni + "' and '" + dataFim + "' ";
        }
        if (ordem != null && !ordem.isEmpty()) {
            if (ordem.equals("ASC")) {
                pesquisa += "ORDER BY c.descricao ASC";
            } else {
                pesquisa += "ORDER BY c.kcalTotal DESC";
            }
            /*
                rCres.setActionCommand("ASC");
                rDesc.setActionCommand("DESC");
             */
        }
        try {
            ResultSet result = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(pesquisa);
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

    public byte[] gerarRelatorio(String nome, String ativo) {
        try {
            Connection conn = ConexaoBD.getInstance().getConnection();
            // Compila o relatorio
            JasperReport relatorio = JasperCompileManager.compileReport(getClass().getResourceAsStream("/relatorios/listagem_categoria.jrxml"));

            // Mapeia campos de parametros para o relatorio, mesmo que nao existam
            Map parametros = new HashMap();
            parametros.put("nome", nome);
            parametros.put("ativo", ativo);

            // Executa relatoio
            byte[] impressao = JasperRunManager.runReportToPdf(relatorio, parametros, conn);

            // Exibe resultado em video
            return impressao;
        } catch (JRException e) {
            JOptionPane.showMessageDialog(null, "Erro ao gerar relatório: " + e);
        }
        return null;
    }
}

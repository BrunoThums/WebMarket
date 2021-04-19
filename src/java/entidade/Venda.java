package entidade;

import java.sql.*;

public class Venda {

    public Integer id;
    public double valor;
    public Integer parcelas;
    public Integer id_pessoa;
    public Integer id_carrinho;

    public static Venda from(ResultSet resultSet) throws SQLException {
        Venda v = new Venda();

        v.id = (resultSet.getInt("id"));
        v.valor = (resultSet.getDouble("valor"));
        v.parcelas = (resultSet.getInt("parcelas"));
        v.id_pessoa = (resultSet.getInt("id_pessoa"));
        v.id_carrinho = (resultSet.getInt("id_carrinho"));

        return v;
    }

    public String toStrig() {
        StringBuilder sb = new StringBuilder();

        sb.append("vendas{id=").append(id);
        sb.append("', valor='").append(valor);
        sb.append("', parcelas='").append(parcelas);
        sb.append("', id_pessoa='").append(id_pessoa);
        sb.append("', id_produto'").append(id_carrinho);
        sb.append('}');

        return sb.toString();
    }

}

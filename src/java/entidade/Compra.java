package entidade;

import java.sql.*;

public class Compra {

    public Integer id;
    public double valor;
    public Integer parcelas;
    public Integer id_pessoa;
    public Integer id_carrinho;

    public static Compra from(ResultSet resultSet) throws SQLException {
        Compra c = new Compra();

        c.id = (resultSet.getInt("id"));
        c.valor = (resultSet.getDouble("valor"));
        c.parcelas = (resultSet.getInt("parcelas"));
        c.id_pessoa = (resultSet.getInt("id_pessoa"));
        c.id_carrinho = (resultSet.getInt("id_carrinho"));

        return c;
    }

    public String toStrig() {
        StringBuilder sb = new StringBuilder();

        sb.append("compra{id=").append(id);
        sb.append("', valor='").append(valor);
        sb.append("', parcelas='").append(parcelas);
        sb.append("', id_pessoa='").append(id_pessoa);
        sb.append("', id_produto'").append(id_carrinho);
        sb.append('}');

        return sb.toString();
    }

}

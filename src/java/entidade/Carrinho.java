package entidade;

import java.sql.*;

public class Carrinho {

    public Integer id;
    public double quant;
    public double precoTotal;
    public Integer id_produto;

    public static Carrinho from(ResultSet resultSet) throws SQLException {
        Carrinho car = new Carrinho();

        car.id = resultSet.getInt("id");
        car.quant = resultSet.getDouble("quant");
        car.precoTotal = resultSet.getDouble("precoTotal");
        car.id_produto = resultSet.getInt("id_produto");

        return car;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("carrinho{id=").append(id);
        sb.append("', quant='").append(quant);
        sb.append("', precoTotal='").append(precoTotal);
        sb.append("', id_produto='").append(id_produto);
        sb.append('}');

        return sb.toString();
    }
}

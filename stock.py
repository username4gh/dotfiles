import tushare as ts

def get_stock_info(id):
    df = ts.get_realtime_quotes(id)
    print(df[['code','name','price','bid','ask','volume','amount','time']])

stock_list = ['300027', '300104', '600037', '601800']
get_stock_info(stock_list)

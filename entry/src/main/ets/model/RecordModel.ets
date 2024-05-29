
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import RecordPO from '../common/bean/RecordPO'
import DbUtil from '../common/utils/DbUtil'

//数据库建表语句
const CREATE_TABLE_SQL:string = `
CREATE TABLE IF NOT EXISTS record (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type_id INTEGER NOT NULL,
  item_id INTEGER NOT NULL,
  amount DOUBLE NOT NULL,
  create_time INTEGER NOT NULL
`

const COLUMNS : ColumnInfo[] = [
  {name:'id',columnName:'id',type:ColumnType.LONG},
  {name:'typeId',columnName:'type_id',type:ColumnType.LONG},
  {name:'itemId',columnName:'item_id',type:ColumnType.LONG},
  {name:'amount',columnName:'amount',type:ColumnType.DOUBLE},
  {name:'creatTime',columnName:'creatTime',type:ColumnType.LONG},
]

const TABLE_NAME = 'record'

class RecordModel{
  getCreateTableSql():string{
    return CREATE_TABLE_SQL
  }

  insert(record:RecordPO){
    return DbUtil.insert(TABLE_NAME,record,COLUMNS)
  }

  dele
}

let recordModel = new RecordModel()

export default recordModel as RecordModel
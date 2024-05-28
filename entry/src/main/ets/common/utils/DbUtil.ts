
import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common'
import Logger from './Logger'
import { ColumnInfo } from '../bean/ColumnInfo'

const DB_FILENAME:string = 'PracticalObject.db'

class DbUtil{
  rdbStore:relationalStore.RdbStore

  initDB(context:common.UIAbilityContext):Promise<void>{
    let config:relationalStore.StoreConfig = {
      name:DB_FILENAME,
      securityLevel:relationalStore.SecurityLevel.S1
    }
    return new Promise<void>((resolve,reject) =>{
      relationalStore.getRdbStore(context,config)
        .then(rdbStore =>{
          this.rdbStore = rdbStore
          Logger.debug('rdbStore 初始化完成！')
          resolve()
        })
        .catch(reason =>{
          Logger.debug('rdbStore 初始化异常',JSON.stringify(reason))
          reject(reason)
        })
    })
  }

  createTable(createSQL:string): Promise<void>{
    return new Promise((resolve,reject) =>{
      this.rdbStore.executeSql(createSQL)
        .then(() =>{
          Logger.debug('创建表成功',createSQL)
          resolve()
        })
        .catch(err =>{
          Logger.error('创建表失败,' + err.message,JSON.stringify(err))
          reject(err)
        })
    })
  }

  //1，新增
  insert(tableName:string,obj:any,columns:ColumnInfo[]){
    return new Promise((resolve,reject) =>{
      //1.构建新增数据
      let value = this.buildValueBucket(obj,columns)
      //2.新增
      this.rdbStore.insert(tableName,value,(err,id) =>{
        if(err){
          Logger.error('新增失败！',JSON.stringify(err))
          reject(err)
        }else {
          Logger.debug('新增成功！新增id：',id.toString())
          resolve(id)
        }
      })
    })
  }
  //2.删除
  delete(predicates:relationalStore.RdbPredicates){
    return new Promise((resolve,reject) =>{
      //1.删除
      this.rdbStore.delete(predicates,(err,rows) =>{
        if(err){
          Logger.error('删除失败！',JSON.stringify(err))
          reject(err)
        }else {
          Logger.debug('删除成功！删除行数：',rows.toString())
          resolve(rows)
        }
      })
    })
  }

  //3.查询
  queryFortList(predicates:relationalStore.RdbPredicates,columns:ColumnInfo[]){
    return new Promise((resolve,reject) =>{
      this.rdbStore.query(predicates,columns.map(info => info.columnName),(err,result) =>{
        if(err){
          Logger.error('查询失败！',JSON.stringify(err))
          reject(err)
        }else {
          Logger.debug('查询成功！查询行数：',result.rowCount.toString())
          resolve(result)
        }
      })
    })
  }


  buildValueBucket(obj:any,columns:ColumnInfo[]):relationalStore.ValuesBucket{
    let value = {}
    columns.forEach(info => {
      let val = obj[info.name]
      if(typeof val !== 'undefined'){
        value[info.columnName] = val
      }
    })
    return value
  }
}

let dbUtil:DbUtil = new DbUtil();
export default dbUtil as DbUtil
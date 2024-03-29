﻿using ApplicationDataAccess;
using Dapper;
using DataAccessLib.Auth.Models;
using DataAccessLib.Base;
using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DataAccessLib.Auth
{
    public class AuthRepository
    {
        ResponseObject responseObject;
        public AuthRepository()
        {
            responseObject = new ResponseObject();
        }

        //-- =========================================================================
        //-- Author       : Raven Quiah
        //-- Create Date  : January 30, 2022
        //-- Updated By   : 
        //-- Updated Date : 
        //-- Description  : Function for logging into the system
        //-- Version      : 1.0
        //-- ============================================================================

        public ResponseObject AuthenticateUser(UserModel user)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@Email", user.Email, DbType.String, ParameterDirection.Input);
            parameters.Add("@Password", user.Password, DbType.String, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Query<UserModel>(@"VerifyUser", parameters, commandType: CommandType.StoredProcedure).AsList();
                if (user_info.Count < 1)
                {
                    responseObject.Message = parameters.Get<string>("@ReturnResult");
                    return responseObject;
                }
                else
                {
                    responseObject.Data = JsonConvert.SerializeObject(user_info);
                    responseObject.Message = parameters.Get<string>("@ReturnResult");
                    return responseObject;
                }
               
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 03 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 03 February 2022
        /// Description  : Function for creating new user account
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public ResponseObject RegisterNewUser(UserModel user)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@RoleId", user.RoleId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@FullName", user.FullName, DbType.String, ParameterDirection.Input);
            parameters.Add("@Email", user.Email, DbType.String, ParameterDirection.Input);
            parameters.Add("@Password", user.Password, DbType.String, ParameterDirection.Input);
            parameters.Add("@IsActive", user.IsActive, DbType.String, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Execute(@"InsertUser", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 15 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 15 February 2022
        /// Description  : Function for Update User
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public ResponseObject UpdateUser(UserModel user)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@UserId", user.UserId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@RoleId", user.RoleId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@FullName", user.FullName, DbType.String, ParameterDirection.Input);
            parameters.Add("@Email", user.Email, DbType.String, ParameterDirection.Input);
            parameters.Add("@IsActive", user.IsActive, DbType.String, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Execute(@"UpdateUser", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 15 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 15 February 2022
        /// Description  : Function for Update User
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public ResponseObject ResetUserPassword(UserModel user)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@UserId", user.UserId, DbType.String, ParameterDirection.Input);
            parameters.Add("@Password", user.Password, DbType.String, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Execute(@"ResetUserPassword", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 15 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 15 February 2022
        /// Description  : Function for De Activate User
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public ResponseObject DeActivateUser(UserModel user)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@UserId", user.UserId, DbType.String, ParameterDirection.Input);
            parameters.Add("@AccessedBy", user.UpdatedBy, DbType.String, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Execute(@"DeActivateUser", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 13 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 13 February 2022
        /// Description  : Function for Assign Supervisor
        /// </summary>
        /// <param name="usersSupervisorModel"></param>
        /// <returns>ResponseObject</returns>
        public ResponseObject AssignSupervisor(UsersSupervisorModel usersSupervisorModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@UserId", usersSupervisorModel.UserId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@SupervisorId", usersSupervisorModel.SupervisorId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@AccessedBy", usersSupervisorModel.CreatedBy, DbType.Int64, direction: ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Execute(@"InsertOrUpdateUserSupervisor", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 13 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 13 February 2022
        /// Description  : Function for Get Supervisors
        /// </summary>
        /// <returns>ResponseObject</returns>
        public ResponseObject GetSupervisors()
        {
            var parameters = new DynamicParameters();
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Query<UserModel>(@"SelectSupervisors", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Data = JsonConvert.SerializeObject(user_info);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        /// <summary>
        /// Developer    : Newton Mitro
        /// Created At   : 16 February 2022
        /// Updated By   : Newton Mitro
        /// Updated At   : 16 February 2022
        /// Description  : Function for Get Users
        /// </summary>
        /// <returns>ResponseObject</returns>
        public ResponseObject GetUsers()
        {
            var parameters = new DynamicParameters();
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var user_info = connetion.Query<UserModel>(@"SelectUsers", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Data = JsonConvert.SerializeObject(user_info);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        private string CreateMD5(string input)
        {
            // Use input string to calculate MD5 hash
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // Convert the byte array to hexadecimal string
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    sb.Append(hashBytes[i].ToString("X2"));
                }
                return sb.ToString();
            }
        }

        //-- =========================================================================
        //-- Author       : Raven Quiah
        //-- Create Date  : January 30, 2022
        //-- Updated By   : 
        //-- Updated Date : 
        //-- Description  : Function for inserting token
        //-- Version      : 1.0
        //-- ============================================================================
        public ResponseObject SaveToken(TokenModel token)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@UserId", token.UserId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@TokenKey", token.TokenKey, DbType.String, ParameterDirection.Input);
            parameters.Add("@IssuedOn", token.IssuedOn, DbType.DateTime, ParameterDirection.Input);
            parameters.Add("@ExpiresOn", token.ExpiresOn, DbType.DateTime, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var token_info = connetion.Query<TokenModel>(@"InsertOrUpdateToken", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Data = JsonConvert.SerializeObject(token_info);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }

        //-- =========================================================================
        //-- Author       : Raven Quiah
        //-- Create Date  : January 30, 2022
        //-- Updated By   : 
        //-- Updated Date : 
        //-- Description  : Function for verifying token
        //-- Version      : 1.0
        //-- ============================================================================
        public ResponseObject VerifyToken(TokenModel token)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@TokenKey", token.TokenKey, DbType.String, ParameterDirection.Input);
            parameters.Add("@UserId", token.UserId, DbType.Int64, ParameterDirection.Input);
            parameters.Add("@ReturnResult", " ", DbType.String, direction: ParameterDirection.Output);
            using (IDbConnection connetion = new SqlConnection(DBConnection.GetConnectionString()))
            {
                var token_info = connetion.Query<TokenModel>(@"VerifyToken", parameters, commandType: CommandType.StoredProcedure);
                responseObject.Data = JsonConvert.SerializeObject(token_info);
                responseObject.Message = parameters.Get<string>("@ReturnResult");
                return responseObject;
            }
        }
    }
}

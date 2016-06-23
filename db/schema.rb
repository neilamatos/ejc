# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150428165022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id", using: :btree
  end

  create_table "estados", force: :cascade do |t|
    t.string   "nome"
    t.string   "uf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "nome"
    t.string   "subject_class"
    t.string   "action"
    t.string   "controller_namespace"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
    t.index ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "nome"
    t.boolean  "uo_dependent", default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "uos", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.string   "cnpj"
    t.string   "endereco"
    t.string   "complemento"
    t.string   "bairro"
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.string   "cep"
    t.string   "codigo_ug"
    t.integer  "codigo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["cidade_id"], name: "index_uos_on_cidade_id", using: :btree
    t.index ["estado_id"], name: "index_uos_on_estado_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "uo_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
    t.index ["uo_id"], name: "index_users_on_uo_id", using: :btree
  end

  add_foreign_key "cidades", "estados"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "uos", "cidades"
  add_foreign_key "uos", "estados"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "uos"
end

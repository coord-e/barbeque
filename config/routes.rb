Barbeque::Engine.routes.draw do
  scope :v1, module: 'api', as: :v1 do
    resources :apps, only: [], param: :name, constraints: { name: /[\w-]+/ } do
      resource :revision_lock, only: [:create, :destroy]
    end

    resources :job_executions, only: :show, param: :message_id,
      constraints: { message_id: /[a-f\d]{8}-([a-f\d]{4}-){3}[a-f\d]{12}/ } do
      resources :job_retries, only: [:create], path: 'retries'
    end

    resources :kuroko2_executions, only: [:show, :create], param: :message_id,
      constraints: { message_id: /[a-f\d]{8}-([a-f\d]{4}-){3}[a-f\d]{12}/ }
  end

  scope :v2, module: 'api', as: :v2 do
    resources :job_executions, only: :create, param: :message_id,
      constraints: { message_id: /[a-f\d]{8}-([a-f\d]{4}-){3}[a-f\d]{12}/ }
  end
end

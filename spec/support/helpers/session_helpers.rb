module Features
    module SessionHelpers
        def sign_up_with(email, password, confirmation)
            visit new_user_registration_path
            fill_in 'Email', with: email
            fill_in 'Senha', with: password
            fill_in 'Confirmação de senha', :with => confirmation
            click_button 'Registrar'
        end

        def signin(email, password)
            visit new_user_session_path
            fill_in 'Email', with: email
            fill_in 'Senha', with: password
            click_button 'Entrar'
        end
    end
end
